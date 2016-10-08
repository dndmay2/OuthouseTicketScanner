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
    var eventArray:[UpcomingEvent] = [] //Need this since eventDict is unordered
    var eventDict: [String: String] = [:]
    // Creating A variable to save the text from the selected label and send it to the next view controller
    var sendSelectedEventID = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        eventTable.dataSource = self
        eventTable.delegate = self
        eventTable.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
        eventTable.backgroundColor = UIColor.black
        
        processAppDefaults()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateEventTable(_:)), name: NSNotification.Name(rawValue: "ShowUpcomingEvents"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getEventsForVenue(_:)), name: NSNotification.Name(rawValue: "GetEventsForVenue"), object: nil)
        getEventDates()
    }
    
    func getEventDates() {
        DataService.getAllUpcomingEventsWithDate()        
    }
    
    func getEventsForVenue(_ notification: Notification) {
        let id = UserDefaults.standard.string(forKey: "venueID")
        if (id != nil) { // This is where it breaks
            print("id is", id!)
            DataService.getUpcomingEventsForVenue(id!)
            print(DataService.dataService.UPCOMING_EVENTS_FOR_VENUE)
        } else {
            print("id is", id)
        }
    }
    
    func processAppDefaults() {
        var appDefaults = Dictionary<String, AnyObject>()
        appDefaults["venueID"] = "0" as AnyObject?
        UserDefaults.standard.register(defaults: appDefaults)
        UserDefaults.standard.synchronize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("in viewDidAppear")
        super.viewDidAppear(animated)
        //eventTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as UITableViewCell!
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "EventCell") as UITableViewCell
        
        cell.textLabel?.text = eventArray[(indexPath as NSIndexPath).row].eventName
        cell.detailTextLabel?.text = eventArray[(indexPath as NSIndexPath).row].eventDate
        print(eventArray[(indexPath as NSIndexPath).row].eventDate)
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.red
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .center
        // cell.textLabel!.font = UIFont(name: "Noteworthy-Bold", size: (cell.textLabel!.font?.pointSize)!)
        cell.textLabel!.font = UIFont(name: "Noteworthy-Bold", size: 30)
        cell.detailTextLabel?.textColor = UIColor.red
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.textAlignment = .center
        cell.detailTextLabel!.font = UIFont.systemFont(ofSize: 18)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }

    func updateEventTable(_ notification: Notification){
        print("myupdate", DataService.dataService.UPCOMING_EVENTS_FOR_VENUE)
        eventArray = []
        eventDict = [:]
        for event in DataService.dataService.UPCOMING_EVENTS_FOR_VENUE {
            eventArray.append(event)
            eventDict[event.eventName] = event.eventId
        }
        eventTable.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("You selected cell #\((indexPath as NSIndexPath).row)!")
        
        // Get Cell Label text here and storing it to the variable
        let indexPathVal: IndexPath = eventTable.indexPathForSelectedRow!
        print("\(indexPathVal)")
        let currentCell = eventTable.cellForRow(at: indexPathVal) as UITableViewCell!;
        print("\(currentCell?.textLabel!.text)")
        //Storing the data to a string from the selected cell
        sendSelectedEventID = eventDict[currentCell!.textLabel!.text!]! as NSString
        print("what i'm going to send:", sendSelectedEventID)
        //Now here I am performing the segue action after cell selection to the other view controller by using the segue Identifier Name
        self.performSegue(withIdentifier: "gotoTicketDetailsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Here i am checking the Segue and Saving the data to an array on the next view Controller also sending it to the next view COntroller
        if segue.identifier == "gotoTicketDetailsVC"{
            //Creating an object of the second View controller
            let controller = segue.destination as! TicketDetailsViewController
            //Sending the data here
            controller.passedInEvent = sendSelectedEventID as String
            
        }
        let backItem = UIBarButtonItem()
        backItem.title = "Events"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
}

