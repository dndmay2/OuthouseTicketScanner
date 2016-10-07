//
//  TicketDetailsViewController.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import UIKit
import AVFoundation

class TicketDetailsViewController: UIViewController {

    @IBOutlet weak var ticketCodeLabel: UILabel!
    @IBOutlet weak var scanMessageLabel: UILabel!
    @IBOutlet weak var ticketsScannedLabel: UILabel!
    @IBOutlet weak var totalTicketsLabel: UILabel!
    @IBOutlet weak var StopSignImage: UIImageView!
    @IBOutlet weak var CheckMarkImage: UIImageView!
    
    var passedInEvent:String!

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PASSED IN", passedInEvent)
        ticketCodeLabel.text = "Press Scan Ticket"
        scanMessageLabel.text = ""
        ticketsScannedLabel.text = "0"
        totalTicketsLabel.text = "0"
        StopSignImage.hidden = true
        CheckMarkImage.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setTicketCountLabels(_:)), name: "ShowTicketCountLabels", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setTicketStatusLabels(_:)), name: "ShowTicketStatusLabels", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showResult(_:)), name: "ShowResultImage", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(lookupTicketScanCount(_:)), name: "UpdateTicketScanCount", object: nil)

        DataService.getTicketCountForEvent(passedInEvent)
        DataService.getScannedTicketCountForEvent(passedInEvent)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func lookupTicketScanCount(notification: NSNotification){
        DataService.getScannedTicketCountForEvent(passedInEvent)
        DataService.getTicketCountForEvent(passedInEvent)
    }
    
    func setTicketCountLabels(notification: NSNotification){
        print("in setTicketCountLabels in TicketDetailsViewController")
        self.ticketsScannedLabel.text = DataService.dataService.NUM_SCANNED_TICKETS
        self.totalTicketsLabel.text = DataService.dataService.NUM_TICKETS
    }
    
    func setTicketStatusLabels(notification: NSNotification){
        print("in setTicketStatusLabels in TicketDetailsViewController")
        print("  code=", DataService.dataService.TICKET_CODE,
              ", message=", DataService.dataService.TICKET_STATUS_MESSAGE)
        
        self.ticketCodeLabel.text = DataService.dataService.TICKET_CODE
        self.scanMessageLabel.text = DataService.dataService.TICKET_STATUS_MESSAGE
        
    }
    
    func showResult(notification: NSNotification){
        print("in showResult in TicketDetailsViewController")
        
        if DataService.dataService.TICKET_STATUS == "true" {
            print("result true\n")
            AudioServicesPlaySystemSound(1333)
            StopSignImage.hidden = true
            CheckMarkImage.hidden = false
        } else if DataService.dataService.TICKET_STATUS == "false" {
            print("result false\n")
            AudioServicesPlaySystemSound(1029)
            StopSignImage.hidden = false
            CheckMarkImage.hidden = true
        } else {
            print("result none\n")
            StopSignImage.hidden = true
            CheckMarkImage.hidden = true
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Here i am checking the Segue and Saving the data to an array on the next view Controller also sending it to the next view COntroller
        print("in prepareForSeque to BarcodeReader")
        if segue.identifier == "gotoBarcodeReaderVC"{
            //Creating an object of the second View controller
            let controller = segue.destinationViewController as! BarcodeReaderViewController
            //Sending the data here
            controller.passedInEvent = passedInEvent as String
            
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Details"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
   }

    

}
