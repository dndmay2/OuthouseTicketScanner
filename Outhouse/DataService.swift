//
//  DataService.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash
import AEXML

class DataService {
    
    static let dataService = DataService()
    
    fileprivate(set) var NUM_TICKETS = "0"
    fileprivate(set) var NUM_SCANNED_TICKETS = "0"
    fileprivate(set) var TICKET_CODE = "Press Scan Ticket"
    fileprivate(set) var TICKET_STATUS = "None"
    fileprivate(set) var TICKET_STATUS_MESSAGE = ""
    fileprivate(set) var UPCOMING_EVENTS_FOR_VENUE: [UpcomingEvent] = []
    fileprivate(set) var UPCOMING_EVENTS_WITH_DATE: [String:String] = [:]
    fileprivate(set) var soapRequest = AEXMLDocument() //Element(name: "Soap")
    //private(set) var TEST_VAR = AnyObject
    
    fileprivate init() {}
    
    static func buildSoapHeader() -> AEXMLElement {
        self.dataService.soapRequest = AEXMLDocument()
        let envelopeAttributes = [ "xmlns:soap" : "http://schemas.xmlsoap.org/soap/envelope/" ]
        let envelope = self.dataService.soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        return body
    }
    
    static func fixXMLPasswordString(_ xml: String) -> String {
        // The AEXML code replaces ' (apostrophe) with &apos;
        // Since this is embedded in the password, it must be converted back
        let newXML = xml.replacingOccurrences(of: "&apos;", with: "'", options: String.CompareOptions.literal)
                                                 //range: xml.characters.indices)
        return newXML
    }
    
    static func buildXml(_ cmd: String, keyWordPairs: [String:String]) -> String {
        let body = self.buildSoapHeader()
        let getTicketCount = body.addChild(name: cmd,
                                           attributes: ["xmlns" : "http://www.outhousetickets.com/"])
        for (key, value) in keyWordPairs {
            //getTicketCount.addChild(name: "EventID", value: TEST_EVENT_ID)
            getTicketCount.addChild(name: key, value: value)
        }
        getTicketCount.addChild(name: "AdminUserName", value: OUTHOUSE_ADMIN)
        getTicketCount.addChild(name: "AdminPassword", value: OUTHOUSE_PASSWORD)
        let xmlString = fixXMLPasswordString(self.dataService.soapRequest.xml)
        return xmlString
    }
    
    static func buildMutableRequest(_ xmlString: String, cmd: String) -> URLRequest {
        let soapLenth = String(xmlString.characters.count)
        let theURL = URL(string: "http://www.outhousetickets.com/webservice/barcodescanner.asmx")
        
        var mutableR = URLRequest(url: theURL!)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.addValue("http://www.outhousetickets.com/" + cmd, forHTTPHeaderField: "SOAPAction")
        mutableR.httpMethod = "POST"
        mutableR.httpBody = xmlString.data(using: String.Encoding.utf8)
        return mutableR
    }
    
    static func postSoapCommand(_ command: String, id: String?, completion : @escaping (XMLIndexer?, NSError?)->()) {
        print("postSoapCommand", command, id, self.dataService.TICKET_CODE)
        var arglist = [String:String]()
        switch command{
        case "ProcessTicketCode":
            arglist = ["EventID": id!, "TicketCode": self.dataService.TICKET_CODE]
        case "GetScannedTicketCountForEvent":
            arglist = ["EventID": id!]
        case "GetTicketCountForEvent":
            arglist = ["EventID": id!]
        case "GetUpcommingEvents_Custom":
            arglist = ["VenueID": id!]
        case "GetUpcommingEvents":
            arglist = [:]
        default:
            print(command, "has no event id passed in")
            arglist = ["EventID": TEST_EVENT_ID]
        }
        let xmlString = DataService.buildXml(command, keyWordPairs: arglist)
        let mutableR = DataService.buildMutableRequest(xmlString, cmd: command)
        
        Alamofire.request(mutableR)
            .validate()
            .responseString { response in
                if(response.result.isSuccess) {
                    let xmlString = response.result.value
                    let xml = SWXMLHash.parse(xmlString!)
                    completion(xml, nil)
                }
                else {
                    completion(nil, response.result.error as NSError?)
                }
        }
    }
    
    static func getTicketCountForEvent(_ eventID: String) {
        let cmd = "GetTicketCountForEvent"
        print("in", cmd, "eventId", eventID)
        DataService.postSoapCommand(cmd, id: eventID){ responseObject, error in
            // use responseObject and error here
            if (responseObject != nil) {
                switch responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"] {
                case .Element(let elem):
                    let count = elem.text!
                    self.dataService.NUM_TICKETS = count
                    print(" ", cmd, count)
                    // Post a notification to let TicketDetailsViewController know we have some data.
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowTicketCountLabels"), object: nil)
                case .XMLError(let error):
                    print("result error1", error)
                default:
                    print("default1")
                }
            }
            else {
                //print("derek", error!.localizedDescription)
                self.dataService.TICKET_STATUS_MESSAGE = "No Internet Connection!"
            }
        }
    }
    
    static func getScannedTicketCountForEvent(_ eventID: String) {
        let cmd = "GetScannedTicketCountForEvent"
        print("in", cmd, "event", eventID)
        DataService.postSoapCommand(cmd, id: eventID){ responseObject, error in
            // use responseObject and error here
            if (responseObject != nil) {
                let count =  responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"].element!.text!
                self.dataService.NUM_SCANNED_TICKETS = count
                print(" ", cmd, count)
            } else {
                //print("derek2", error!.localizedDescription )
                self.dataService.TICKET_STATUS_MESSAGE = "No Internet Connection!"
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowTicketStatusLabels"), object: nil)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowTicketCountLabels"), object: nil)
        }
    }
    
    static func processTicketCode(_ eventID: String, codeNumber: String) {
        let cmd = "ProcessTicketCode"
        print("In", cmd, "codeNumber:", codeNumber)
        self.dataService.TICKET_CODE = codeNumber
        DataService.postSoapCommand(cmd, id: eventID){ responseObject, error in
            if (responseObject != nil) {
                // use responseObject and error here
                switch responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"] {
                case .Element(let elem):
                    // everything is good, code away!
                    let result = elem.text!
                    self.dataService.TICKET_STATUS = result
                    print(" ", cmd, result)
                case .XMLError(let error):
                    // error is an XMLIndexer.Error instance that you can deal with
                    print("result error", error)
                default:
                    print("default")
                }
                switch responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"]["message"] {
                case .Element(let elem):
                    // everything is good, code away!
                    let result = elem.text!
                    self.dataService.TICKET_STATUS_MESSAGE = result
                    print(" message:", result)
                case .XMLError:
                    // error is an XMLIndexer.Error instance that you can deal with
                    self.dataService.TICKET_STATUS_MESSAGE = "Valid Ticket"
                default:
                    print("default")
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowTicketStatusLabels"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowResultImage"), object: nil)
            } else {
                //print("derek3",  error!.localizedDescription, error!.code)
                self.dataService.NUM_SCANNED_TICKETS = String(Int(self.dataService.NUM_SCANNED_TICKETS)!+1)
                if (error!.code == -1009) {
                    self.dataService.TICKET_STATUS_MESSAGE = "No Internet Connection!"
                }
                else {
                    self.dataService.TICKET_STATUS_MESSAGE = "Connection Error!"
                }
            }
        }
    }
    
    static func getUpcomingEventsForVenue(_ venue: String) {
        let cmd = "GetUpcommingEvents_Custom"
        print("in", cmd)
        DataService.postSoapCommand(cmd, id: venue){ responseObject, error in
            var events: [UpcomingEvent] = []
            var event: UpcomingEvent
            var date: String!
            // use responseObject and error here
            for elem in responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"]["diffgr:diffgram"]["NewDataSet"]["Table1"] {
                date = self.dataService.UPCOMING_EVENTS_WITH_DATE[elem["EventID"].element!.text!]
                if date == nil {
                    date = "1/1/2001"
                }
                event = UpcomingEvent(id: elem["EventID"].element!.text!, name: elem["EventName"].element!.text!, date: date)
                events.append(event)
            }
            self.dataService.UPCOMING_EVENTS_FOR_VENUE = events
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ShowUpcomingEvents"), object: nil)
        }
    }

    static func getAllUpcomingEventsWithDate() {
        let cmd = "GetUpcommingEvents"
        print("in", cmd)
        DataService.postSoapCommand(cmd, id: nil){ responseObject, error in
            // use responseObject and error here
            for elem in responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"]["diffgr:diffgram"]["NewDataSet"]["Table1"] {
                let arr = elem["EventName"].element!.text!.components(separatedBy: "-")
                self.dataService.UPCOMING_EVENTS_WITH_DATE[elem["EventID"].element!.text!] = arr.last!
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GetEventsForVenue"), object: nil)
        }
    }

}
