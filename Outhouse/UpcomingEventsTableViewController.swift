//
//  UpcomingEventsViewController.swift
//  Outhouse
//
//  Created by Derek May on 9/17/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

//import Foundation
import UIKit

class UpcomingEventsTableViewController: UITableViewController {
    
    @IBOutlet var eventTable: UITableView!
    var eventArray:[String] = []
    // Creating A variable to save the text from the selected label and send it to the next view controller
    var sendSelectedData = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventTable.dataSource = self
        eventTable.delegate = self
        eventTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customcell")
        
        processAppDefaults()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateEventTable(_:)), name: "ShowUpcomingEvents", object: nil)
        
        let id = NSUserDefaults.standardUserDefaults().stringForKey("venueID")
        if (id != nil) { // This is where it breaks
            print("id is", id!)
            DataService.getUpcomingEventsForVenue(id!)
            print(DataService.dataService.UPCOMING_EVENTS)
        } else {
            print("id is", id)
        }
    }
    
    func processAppDefaults() {
        var appDefaults = Dictionary<String, AnyObject>()
        appDefaults["venueID"] = "0"
        NSUserDefaults.standardUserDefaults().registerDefaults(appDefaults)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("in reload", DataService.dataService.UPCOMING_EVENTS)
        super.viewDidAppear(animated)
        eventTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as UITableViewCell!
        cell.textLabel?.text = eventArray[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }

    func updateEventTable(notification: NSNotification){
        print("myupdate", DataService.dataService.UPCOMING_EVENTS)
        eventArray = []
        for event in DataService.dataService.UPCOMING_EVENTS {
            eventArray.append(event.eventName)
        }
        eventTable.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label text here and storing it to the variable
        let indexPathVal: NSIndexPath = eventTable.indexPathForSelectedRow!
        print("\(indexPathVal)")
        let currentCell = eventTable.cellForRowAtIndexPath(indexPathVal) as UITableViewCell!;
        print("\(currentCell.textLabel!.text)")
        //Storing the data to a string from the selected cell
        sendSelectedData = currentCell.textLabel!.text!
        print("what i'm going to send:", sendSelectedData)
        //Now here I am performing the segue action after cell selection to the other view controller by using the segue Identifier Name
        self.performSegueWithIdentifier("scanForEvent", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Here i am checking the Segue and Saving the data to an array on the next view Controller also sending it to the next view COntroller
        if segue.identifier == "scanForEvent"{
            //Creating an object of the second View controller
            let controller = segue.destinationViewController as! TicketDetailsViewController
            //Sending the data here
            controller.passedInEvent = sendSelectedData as String
            
        }
    }
}

