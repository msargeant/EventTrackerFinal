//
//  EventTableViewController.swift
//  EventTrackerFinal
//
//  Created by Matthew Sargeant on 10/10/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import UIKit
import os.log

class EventTableViewController: UITableViewController {
  
  // MARK: Properties
  var events = [Event]()
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      // Use the edit button item provided by the table view controller.
      navigationItem.leftBarButtonItem = editButtonItem
      
      // Load the sample data
      loadSampleEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return events.count
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    // Table view cells are reused and should be dequeued using a cell identifier.
    let cellIdentifier = "EventTableViewCell"
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
      fatalError("The dequeued cell is not an instance of EventTableViewCell.")
    }
    
    // Fetches the appropriate event for the data source layout
    let event = events[indexPath.row]

    cell.nameLabel.text = event.name
    cell.photoImageView.image = event.photo
    cell.ratingControl.rating = event.rating

    
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    switch(segue.identifier ?? "") {
      
    case "AddItem":
      os_log("Adding a new meal.", log: OSLog.default, type: .debug)
      
    case "ShowDetail":
      guard let eventDetailViewController = segue.destination as? EventViewController
        else {
          fatalError("Unexpected destination: \(segue.destination)")
      }
      
      guard let selectedEventCell = sender as? EventTableViewCell else {
        fatalError("Unexpected sender: \(String(describing: sender))")
      }
      
      guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
        fatalError("The selected cell is not being displayed by the table")
      }
      
      let selectedEvent = events[indexPath.row]
      eventDetailViewController.event = selectedEvent
      
    default:
      fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
    }
  }
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      events.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if yo do not want the specified item to be editable.
    return true
  }
  
  // MARK: Actions
  @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? EventViewController, let event = sourceViewController.event {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        // Update an existing event.
        events[selectedIndexPath.row] = event
        tableView.reloadRows(at: [selectedIndexPath], with: .none)
      } else {
        // Add a new event.
        let newIndexPath = IndexPath(row: events.count, section: 0)
        
        events.append(event)
        
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }      
    }
  }
  
  // MARK: Methods
  private func loadSampleEvents(){
    let photo1 = UIImage(named: "event1")
    let photo2 = UIImage(named: "event2")
    let photo3 = UIImage(named: "event3")
    
    guard let event1 = Event(name: "Fun Music Festival", photo: photo1, rating: 4) else {
      fatalError("Unable to instantiate event1")
    }
    
    guard let event2 = Event(name: "Farmers Market", photo: photo2, rating: 3) else {
      fatalError("Unable to instantiate event2")
    }
    
    guard let event3 = Event(name: "Lame Music Festival", photo: photo3, rating: 1) else {
      fatalError("Unable to instantiate event3")
    }
    
    events += [event1, event2, event3]
    
    
    
  }

}























