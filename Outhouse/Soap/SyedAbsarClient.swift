 
/* 
Copyright (c) 2016 Syed Absar Karim https://www.linkedin.com/in/syedabsar

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
 
import Foundation

/* Soap Client Generated from WSDL: http://www.outhousetickets.com/webservice/barcodescanner.asmx?WSDL powered by http://www.wsdl2swift.com */

public class SyedAbsarClient {

/**
    Calls the SOAP Operation: ProcessTicketCode with Message based on ProcessTicketCode Object.

    - parameter processTicketCode:  ProcessTicketCode Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opProcessTicketCode(processTicketCode : ProcessTicketCode , completionHandler: (ProcessTicketCodeResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:ProcessTicketCode><ns1:EventID>0</ns1:EventID><ns1:TicketCode>%@</ns1:TicketCode><ns1:message>%@</ns1:message><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword></ns1:ProcessTicketCode></SOAP-ENV:Body></SOAP-ENV:Envelope>",processTicketCode.cpEventID!,processTicketCode.cpTicketCode!,processTicketCode.cpMessage!,processTicketCode.cpAdminUserName!,processTicketCode.cpAdminPassword!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/ProcessTicketCode", soapMessage: soapMessage, soapVersion: "1", className:"ProcessTicketCodeResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? ProcessTicketCodeResponse,error) })
 }

/**
    Calls the SOAP Operation: GetUpcommingEvents with Message based on GetUpcommingEvents Object.

    - parameter getUpcommingEvents:  GetUpcommingEvents Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetUpcommingEvents(getUpcommingEvents : GetUpcommingEvents , completionHandler: (GetUpcommingEventsResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:GetUpcommingEvents><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword></ns1:GetUpcommingEvents></SOAP-ENV:Body></SOAP-ENV:Envelope>",getUpcommingEvents.cpAdminUserName!,getUpcommingEvents.cpAdminPassword!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/GetUpcommingEvents", soapMessage: soapMessage, soapVersion: "1", className:"GetUpcommingEventsResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetUpcommingEventsResponse,error) })
 }

/**
    Calls the SOAP Operation: GetUpcommingEvents_Custom with Message based on GetUpcommingEvents_Custom Object.

    - parameter getUpcommingEvents_Custom:  GetUpcommingEvents_Custom Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetUpcommingEvents_Custom(getUpcommingEvents_Custom : GetUpcommingEvents_Custom , completionHandler: (GetUpcommingEvents_CustomResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:GetUpcommingEvents_Custom><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword><ns1:VenueID>0</ns1:VenueID></ns1:GetUpcommingEvents_Custom></SOAP-ENV:Body></SOAP-ENV:Envelope>",getUpcommingEvents_Custom.cpAdminUserName!,getUpcommingEvents_Custom.cpAdminPassword!,getUpcommingEvents_Custom.cpVenueID!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/GetUpcommingEvents_Custom", soapMessage: soapMessage, soapVersion: "1", className:"GetUpcommingEvents_CustomResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetUpcommingEvents_CustomResponse,error) })
 }

/**
    Calls the SOAP Operation: GetTicketDBForEvent with Message based on GetTicketDBForEvent Object.

    - parameter getTicketDBForEvent:  GetTicketDBForEvent Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetTicketDBForEvent(getTicketDBForEvent : GetTicketDBForEvent , completionHandler: (GetTicketDBForEventResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:GetTicketDBForEvent><ns1:EventID>0</ns1:EventID><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword></ns1:GetTicketDBForEvent></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTicketDBForEvent.cpEventID!,getTicketDBForEvent.cpAdminUserName!,getTicketDBForEvent.cpAdminPassword!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/GetTicketDBForEvent", soapMessage: soapMessage, soapVersion: "1", className:"GetTicketDBForEventResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetTicketDBForEventResponse,error) })
 }

/**
    Calls the SOAP Operation: GetTicketCountForEvent with Message based on GetTicketCountForEvent Object.

    - parameter getTicketCountForEvent:  GetTicketCountForEvent Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetTicketCountForEvent(getTicketCountForEvent : GetTicketCountForEvent , completionHandler: (GetTicketCountForEventResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:GetTicketCountForEvent><ns1:EventID>0</ns1:EventID><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword></ns1:GetTicketCountForEvent></SOAP-ENV:Body></SOAP-ENV:Envelope>",getTicketCountForEvent.cpEventID!,getTicketCountForEvent.cpAdminUserName!,getTicketCountForEvent.cpAdminPassword!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/GetTicketCountForEvent", soapMessage: soapMessage, soapVersion: "1", className:"GetTicketCountForEventResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetTicketCountForEventResponse,error) })
 }

/**
    Calls the SOAP Operation: GetScannedTicketCountForEvent with Message based on GetScannedTicketCountForEvent Object.

    - parameter getScannedTicketCountForEvent:  GetScannedTicketCountForEvent Object.
    - parameter completionHandler:  The Callback Handler.

    - returns: Void.
*/
public func opGetScannedTicketCountForEvent(getScannedTicketCountForEvent : GetScannedTicketCountForEvent , completionHandler: (GetScannedTicketCountForEventResponse?, NSError?) -> Void) { 

let soapMessage = String(format:"<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ns1=\"http://www.outhousetickets.com/\"><SOAP-ENV:Body><ns1:GetScannedTicketCountForEvent><ns1:EventID>0</ns1:EventID><ns1:AdminUserName>%@</ns1:AdminUserName><ns1:AdminPassword>%@</ns1:AdminPassword></ns1:GetScannedTicketCountForEvent></SOAP-ENV:Body></SOAP-ENV:Envelope>",getScannedTicketCountForEvent.cpEventID!,getScannedTicketCountForEvent.cpAdminUserName!,getScannedTicketCountForEvent.cpAdminPassword!)

self.makeSoapConnection("http://www.outhousetickets.com/webservice/barcodescanner.asmx", soapAction: "http://www.outhousetickets.com/GetScannedTicketCountForEvent", soapMessage: soapMessage, soapVersion: "1", className:"GetScannedTicketCountForEventResponse", completionHandler: { (syedabsarObj:SyedAbsarObjectBase?, error: NSError? )->Void in completionHandler(syedabsarObj  as? GetScannedTicketCountForEventResponse,error) })
 }



/**
    Private Method: Make Soap Connection.
    
    - parameter soapLocation: String.
    - soapAction: String.
    - soapMessage: String.
    - soapVersion: String (1.1 Or 1.2).
    - className: String.
    - completionHandler: Handler.
    - returns: Void.
    */
private func makeSoapConnection(soapLocation: String, soapAction: String, soapMessage: String,  soapVersion: String, className: String, completionHandler: (SyedAbsarObjectBase?, NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: soapLocation)!)
        let msgLength  = String(soapMessage.characters.count)
        let data = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        request.HTTPMethod = "POST"
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        // request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        request.HTTPBody = data
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let datastring = NSString(data: data!, encoding:NSUTF8StringEncoding) as! String
            print(datastring)
            
            //This is a temporary code where it returns the actual XML Response
            //At the moment, response parsing and mapping is under progress
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            let currentResp = aClass.newInstance()
            currentResp.xmlResponseString = "\(datastring)"
            completionHandler(currentResp, error)
            return

			//TODO: Code in progress for response parsing and mapping
			/*
            let xml = SWXMLHash.parse(datastring)
            
            let  coreElementKey = className
            
            let aClass = NSClassFromString(className) as! SyedAbsarObjectBase.Type
            
            let obj = aClass
            
            let inst = obj.newInstance()
            
			var error : NSError?
            let soapFault = xml["soap:Envelope"]["soap:Body"]["soap:Fault"]
            
            if soapFault {
            
                let val =  soapFault["faultstring"].element?.text
                
                error =  NSError(domain: "soapFault", code: 0, userInfo: NSDictionary(object: val!, forKey: NSLocalizedDescriptionKey) as [NSObject : AnyObject])
            }
            
            if (error == nil) {
                for key in obj.cpKeys()  {
                    
                    let body =  xml["soap:Envelope"]["soap:Body"]
                    let val =  body[coreElementKey][key].element?.text
                    
                    inst.setValue(val, forKeyPath: "cp"+key)
                    
                    print (inst)
                }
            }
            completionHandler(inst, error)
            */

        }
        task.resume()

    }    




}
/** 
  Process Ticket Code. 
*/
@objc(ProcessTicketCode)
public class ProcessTicketCode : SyedAbsarObjectBase {


/// Event I D
var cpEventID: Int?

/// Ticket Code
var cpTicketCode: String?

/// Message
var cpMessage: String?

/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

override static func cpKeys() -> Array<String> {
return ["EventID","TicketCode","Message","AdminUserName","AdminPassword"]
}
}

/** 
  Process Ticket Code Response. 
*/
@objc(ProcessTicketCodeResponse)
public class ProcessTicketCodeResponse : SyedAbsarObjectBase {


/// Process Ticket Code Result
var cpProcessTicketCodeResult: Bool?

/// Message
var cpMessage: String?

override static func cpKeys() -> Array<String> {
return ["ProcessTicketCodeResult","Message"]
}
}

/** 
  Get Upcomming Events. 
*/
@objc(GetUpcommingEvents)
public class GetUpcommingEvents : SyedAbsarObjectBase {


/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

override static func cpKeys() -> Array<String> {
return ["AdminUserName","AdminPassword"]
}
}

/** 
  Get Upcomming Events Response. 
*/
@objc(GetUpcommingEventsResponse)
public class GetUpcommingEventsResponse : SyedAbsarObjectBase {


/// Get Upcomming Events Result
var cpGetUpcommingEventsResult: String?

override static func cpKeys() -> Array<String> {
return ["GetUpcommingEventsResult"]
}
}

/** 
  Get Upcomming Events Result. 
*/
@objc(GetUpcommingEventsResult)
public class GetUpcommingEventsResult : SyedAbsarObjectBase {


/// Schema
var cpSchema: String?

/// Any
var cpAny: String?

override static func cpKeys() -> Array<String> {
return ["Schema","Any"]
}
}

/** 
  Get Upcomming Events_ Custom. 
*/
@objc(GetUpcommingEvents_Custom)
public class GetUpcommingEvents_Custom : SyedAbsarObjectBase {


/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

/// Venue I D
var cpVenueID: Int?

override static func cpKeys() -> Array<String> {
return ["AdminUserName","AdminPassword","VenueID"]
}
}

/** 
  Get Upcomming Events_ Custom Response. 
*/
@objc(GetUpcommingEvents_CustomResponse)
public class GetUpcommingEvents_CustomResponse : SyedAbsarObjectBase {


/// Get Upcomming Events_ Custom Result
var cpGetUpcommingEvents_CustomResult: String?

override static func cpKeys() -> Array<String> {
return ["GetUpcommingEvents_CustomResult"]
}
}

/** 
  Get Upcomming Events_ Custom Result. 
*/
@objc(GetUpcommingEvents_CustomResult)
public class GetUpcommingEvents_CustomResult : SyedAbsarObjectBase {


/// Schema
var cpSchema: String?

/// Any
var cpAny: String?

override static func cpKeys() -> Array<String> {
return ["Schema","Any"]
}
}

/** 
  Get Ticket D B For Event. 
*/
@objc(GetTicketDBForEvent)
public class GetTicketDBForEvent : SyedAbsarObjectBase {


/// Event I D
var cpEventID: Int?

/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

override static func cpKeys() -> Array<String> {
return ["EventID","AdminUserName","AdminPassword"]
}
}

/** 
  Get Ticket D B For Event Response. 
*/
@objc(GetTicketDBForEventResponse)
public class GetTicketDBForEventResponse : SyedAbsarObjectBase {


/// Get Ticket D B For Event Result
var cpGetTicketDBForEventResult: String?

override static func cpKeys() -> Array<String> {
return ["GetTicketDBForEventResult"]
}
}

/** 
  Get Ticket D B For Event Result. 
*/
@objc(GetTicketDBForEventResult)
public class GetTicketDBForEventResult : SyedAbsarObjectBase {


/// Schema
var cpSchema: String?

/// Any
var cpAny: String?

override static func cpKeys() -> Array<String> {
return ["Schema","Any"]
}
}

/** 
  Get Ticket Count For Event. 
*/
@objc(GetTicketCountForEvent)
public class GetTicketCountForEvent : SyedAbsarObjectBase {


/// Event I D
var cpEventID: Int?

/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

override static func cpKeys() -> Array<String> {
return ["EventID","AdminUserName","AdminPassword"]
}
}

/** 
  Get Ticket Count For Event Response. 
*/
@objc(GetTicketCountForEventResponse)
public class GetTicketCountForEventResponse : SyedAbsarObjectBase {


/// Get Ticket Count For Event Result
var cpGetTicketCountForEventResult: Int?

override static func cpKeys() -> Array<String> {
return ["GetTicketCountForEventResult"]
}
}

/** 
  Get Scanned Ticket Count For Event. 
*/
@objc(GetScannedTicketCountForEvent)
public class GetScannedTicketCountForEvent : SyedAbsarObjectBase {


/// Event I D
var cpEventID: Int?

/// Admin User Name
var cpAdminUserName: String?

/// Admin Password
var cpAdminPassword: String?

override static func cpKeys() -> Array<String> {
return ["EventID","AdminUserName","AdminPassword"]
}
}

/** 
  Get Scanned Ticket Count For Event Response. 
*/
@objc(GetScannedTicketCountForEventResponse)
public class GetScannedTicketCountForEventResponse : SyedAbsarObjectBase {


/// Get Scanned Ticket Count For Event Result
var cpGetScannedTicketCountForEventResult: Int?

override static func cpKeys() -> Array<String> {
return ["GetScannedTicketCountForEventResult"]
}
}


/**
    A generic base class for all Objects.
*/
public class SyedAbsarObjectBase : NSObject
{
    var xmlResponseString: String?

    class func cpKeys() -> Array <String>
    {
        return []
    }
    
    required override public init(){}
  
    class func newInstance() -> Self {
        return self.init()
    }


}