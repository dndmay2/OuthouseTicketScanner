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
    @IBOutlet weak var eventNameLabel: UILabel!
    
    var passedInEventId:String!
    var passedInEventName:String!
    let defaults = UserDefaults.init()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PASSED IN", passedInEventId)
        ticketCodeLabel.text = "Press Scan Ticket"
        scanMessageLabel.text = ""
        ticketsScannedLabel.text = "0"
        totalTicketsLabel.text = "0"
        StopSignImage.isHidden = true
        CheckMarkImage.isHidden = true
        self.eventNameLabel.text = passedInEventName
        //self.eventNameLabel.text = "This is a very, very, very long event name that should span multiple lines"
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTicketCountLabels(_:)), name: NSNotification.Name(rawValue: "ShowTicketCountLabels"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setTicketStatusLabels(_:)), name: NSNotification.Name(rawValue: "ShowTicketStatusLabels"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showResult(_:)), name: NSNotification.Name(rawValue: "ShowResultImage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(lookupTicketScanCount(_:)), name: NSNotification.Name(rawValue: "UpdateTicketScanCount"), object: nil)

        DataService.getTicketCountForEvent(passedInEventId)
        DataService.getScannedTicketCountForEvent(passedInEventId)
    }
    
    @IBAction func navBarInfoButton(_ sender: AnyObject) {
        let venueId = defaults.string(forKey: "venueID")
        let msg = "Venue ID: \(venueId!)\nEvent ID: \(passedInEventId!)\nhttp://www.outhousetickets.com"
        let alertController = UIAlertController(title: "Outhouse Tickets", message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        let webAction = UIAlertAction(title: "Visit Web Page", style: .default, handler: visitOuthouseWebPage)
        alertController.addAction(webAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func visitOuthouseWebPage(alert: UIAlertAction!) {
        if let url = URL(string: "https://www.outhousetickets.com") {
            UIApplication.shared.openURL(url)
        }
    }

    func lookupTicketScanCount(_ notification: Notification){
        DataService.getScannedTicketCountForEvent(passedInEventId)
        DataService.getTicketCountForEvent(passedInEventId)
    }
    
    func setTicketCountLabels(_ notification: Notification){
        print("in setTicketCountLabels in TicketDetailsViewController")
        self.ticketsScannedLabel.text = DataService.dataService.NUM_SCANNED_TICKETS
        self.totalTicketsLabel.text = DataService.dataService.NUM_TICKETS
    }
    
    func setTicketStatusLabels(_ notification: Notification){
        print("in setTicketStatusLabels in TicketDetailsViewController")
        print("  code=", DataService.dataService.TICKET_CODE,
              ", message=", DataService.dataService.TICKET_STATUS_MESSAGE)
        
        self.ticketCodeLabel.text = DataService.dataService.TICKET_CODE
        self.scanMessageLabel.text = DataService.dataService.TICKET_STATUS_MESSAGE
        
    }
    
    func showResult(_ notification: Notification){
        print("in showResult in TicketDetailsViewController")
        let soundEffects = defaults.bool(forKey: "soundEffects")
        print("soundEffects = ", soundEffects)
        if DataService.dataService.TICKET_STATUS == "true" {
            print("result true\n")
            if soundEffects {
                AudioServicesPlaySystemSound(1333)
            }
            StopSignImage.isHidden = true
            CheckMarkImage.isHidden = false
        } else if DataService.dataService.TICKET_STATUS == "false" {
            print("result false\n")
            if soundEffects {
                AudioServicesPlaySystemSound(1029)
            }
            StopSignImage.isHidden = false
            CheckMarkImage.isHidden = true
        } else {
            print("result none\n")
            StopSignImage.isHidden = true
            CheckMarkImage.isHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Here i am checking the Segue and Saving the data to an array on the next view Controller also sending it to the next view COntroller
        print("in prepareForSeque to BarcodeReader")
        if segue.identifier == "gotoBarcodeReaderVC"{
            //Creating an object of the second View controller
            let controller = segue.destination as! BarcodeReaderViewController
            //Sending the data here
            controller.passedInEventId = passedInEventId as String
            
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Details"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
   }

    

}
