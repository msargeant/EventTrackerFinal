//
//  EventTableViewController.swift
//  EventTrackerFinal
//
//  Created by Matthew Sargeant on 10/10/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
  
  // MARK: Properties
  var events = [Event]()
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
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























