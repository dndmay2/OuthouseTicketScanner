//
//  DataService.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SWXMLHash
import AEXML

//let DISCOGS_KEY = "typuukemgRjvIOPjgBYk"
//let DISCOGS_SECRET = "OarbROatkpekEwGuPBpiZweGXPeBoQOa"
//let DISCOGS_AUTH_URL = "https://api.discogs.com/database/search?q="

class DataService {
    
    static let dataService = DataService()
    
    private(set) var NUM_TICKETS = "0"
    private(set) var NUM_SCANNED_TICKETS = "0"
    private(set) var TICKET_CODE = "Let's scan a ticket"
    private(set) var TICKET_STATUS = ""
    private(set) var TICKET_STATUS_MESSAGE = "Message"
    private(set) var soapRequest = AEXMLElement()
    //private(set) var TEST_VAR = AnyObject
    
    private init() {}
    
    static func buildSoapHeader() -> AEXMLElement {
        self.dataService.soapRequest = AEXMLDocument()
        let envelopeAttributes = [ "xmlns:soap" : "http://schemas.xmlsoap.org/soap/envelope/" ]
        let envelope = self.dataService.soapRequest.addChild(name: "soap:Envelope", attributes: envelopeAttributes)
        let body = envelope.addChild(name: "soap:Body")
        return body
    }
    
    static func fixXMLPasswordString(xml: String) -> String {
        // The AEXML code replaces ' (apostrophe) with &apos;
        // Since this is embedded in the password, it must be converted back
        xml.stringByReplacingOccurrencesOfString("&apos;",
                                                 withString: "'",
                                                 options: NSStringCompareOptions.LiteralSearch,
                                                 range: xml.startIndex..<xml.endIndex)
        return xml
    }
    
    static func buildXml(cmd: String, keyWordPairs: [String:String]) -> String {
        let body = self.buildSoapHeader()
        let getTicketCount = body.addChild(name: cmd,
                                           attributes: ["xmlns" : "http://www.outhousetickets.com/"])
        for (key, value) in keyWordPairs {
            //getTicketCount.addChild(name: "EventID", value: TEST_EVENT_ID)
            getTicketCount.addChild(name: key, value: value)
        }
        getTicketCount.addChild(name: "AdminUserName", value: OUTHOUSE_ADMIN)
        getTicketCount.addChild(name: "AdminPassword", value: OUTHOUSE_PASSWORD)
        let xmlString = fixXMLPasswordString(self.dataService.soapRequest.xmlString)
        return xmlString
    }
    
    static func buildMutableRequest(xmlString: String, cmd: String) -> NSMutableURLRequest {
        let soapLenth = String(xmlString.characters.count)
        let theURL = NSURL(string: "http://www.outhousetickets.com/webservice/barcodescanner.asmx")
        
        let mutableR = NSMutableURLRequest(URL: theURL!)
        mutableR.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        mutableR.addValue(soapLenth, forHTTPHeaderField: "Content-Length")
        mutableR.addValue("http://www.outhousetickets.com/" + cmd, forHTTPHeaderField: "SOAPAction")
        mutableR.HTTPMethod = "POST"
        mutableR.HTTPBody = xmlString.dataUsingEncoding(NSUTF8StringEncoding)
        return mutableR
    }
    
    static func postSoapCommand(command: String, completion : (XMLIndexer?, NSError?)->()) {
        var arglist = [String:String]()
        switch command{
        case "ProcessTicketCode":
            arglist = ["EventID": TEST_EVENT_ID, "TicketCode": self.dataService.TICKET_CODE]
        case "GetScannedTicketCountForEvent":
            arglist = ["EventID": TEST_EVENT_ID]
        default:
            arglist = ["EventID": TEST_EVENT_ID]
        }
        let xmlString = DataService.buildXml(command, keyWordPairs: arglist)
        let mutableR = DataService.buildMutableRequest(xmlString, cmd: command)
        
        Alamofire.request(mutableR)
            .validate()
            .responseString { response in
                switch response.result {
                case .Success:
                    let xmlString = response.result.value
                    let xml = SWXMLHash.parse(xmlString!)
                    completion(xml, nil)
                case .Failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    static func getTicketCountForEvent() {
        let cmd = "GetTicketCountForEvent"
        DataService.postSoapCommand(cmd){ responseObject, error in
            // use responseObject and error here
            let count = responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"].element!.text!
            self.dataService.NUM_TICKETS = count
            // Post a notification to let AlbumDetailsViewController know we have some data.
            NSNotificationCenter.defaultCenter().postNotificationName("TicketNotification", object: nil)
        }
    }
    
    static func getScannedTicketCountForEvent() {
        let cmd = "GetScannedTicketCountForEvent"
        DataService.postSoapCommand(cmd){ responseObject, error in
            // use responseObject and error here
            let count =  responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"].element!.text!
            self.dataService.NUM_SCANNED_TICKETS = count
            print(cmd, count)
            NSNotificationCenter.defaultCenter().postNotificationName("TicketNotification", object: nil)
        }
    }
    
    static func processTicketCode(codeNumber: String) {
        let cmd = "ProcessTicketCode"
        self.dataService.TICKET_CODE = codeNumber
        DataService.postSoapCommand(cmd){ responseObject, error in
            // use responseObject and error here
            switch responseObject!["soap:Envelope"]["soap:Body"][cmd + "Response"][cmd + "Result"] {
            case .Element(let elem):
                // everything is good, code away!
                let result = elem.text!
                self.dataService.TICKET_STATUS = result
                print(result)
                NSNotificationCenter.defaultCenter().postNotificationName("TicketNotification", object: nil)
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
                print(result)
                NSNotificationCenter.defaultCenter().postNotificationName("TicketNotification", object: nil)
            case .XMLError:
                // error is an XMLIndexer.Error instance that you can deal with
                self.dataService.TICKET_STATUS_MESSAGE = "Valid Ticket"
                NSNotificationCenter.defaultCenter().postNotificationName("TicketNotification", object: nil)
            default:
                print("default")
            }
        }
    }
}
