//
//  AlbumDetailsViewController.swift
//  Outhouse
//
//  Created by Derek May on 8/21/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var artistAlbumLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ticketsScannedLabel: UILabel!
    @IBOutlet weak var totalTicketsLabel: UILabel!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistAlbumLabel.text = "Let's scan a ticket!"
        yearLabel.text = ""
        ticketsScannedLabel.text = "0"
        totalTicketsLabel.text = "0"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(setLabels(_:)), name: "TicketNotification", object: nil)

        DataService.getTicketCountForEvent()
        DataService.getScannedTicketCountForEvent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setLabels(notification: NSNotification){
        print("in setLabels in AlbumDetailsViewController")
        
        // Use the data from DataService.swift to initialize the Album.
        let eventTicketInfo = EventTickets(numTicketsScanned: DataService.dataService.NUM_SCANNED_TICKETS, numTotalTickets: DataService.dataService.NUM_TICKETS)
        
        //dispatch_async(dispatch_get_main_queue()) {
            self.ticketsScannedLabel.text = "\(eventTicketInfo.ticketsScanned)"
        //}
        
        //dispatch_async(dispatch_get_main_queue()) {
            self.totalTicketsLabel.text = "\(eventTicketInfo.totalTickets)"
        //}
        
        //dispatch_async(dispatch_get_main_queue()) {
            print(DataService.dataService.TICKET_CODE, DataService.dataService.TICKET_STATUS_MESSAGE)
            self.artistAlbumLabel.text = DataService.dataService.TICKET_CODE
            self.yearLabel.text = DataService.dataService.TICKET_STATUS_MESSAGE
        //}
        
    }
    
    

}
