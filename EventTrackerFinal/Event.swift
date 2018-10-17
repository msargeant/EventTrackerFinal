












//
//  Event.swift
//  EventTrackerFinal
//
//  Created by Matthew Sargeant on 10/9/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import UIKit
import os.log

class Event: NSObject, NSCoding {

  // MARK: Properties
  
  var name: String
  var date: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
  
  // MARK: Types
  
  struct PropertyKey {
    static let name = "name"
    static let date = "date"
    static let photo = "photo"
    static let rating = "rating"
  }
  
  // MARK: Initialization
  
  init?(name: String, date: String, photo: UIImage?, rating: Int) {
    
    // The name must not be empty
    guard !name.isEmpty else {
      return nil
    }

    // The rating must be between 0 and 5 inclusively
    guard (rating >= 0) && (rating <= 5) else {
      return nil
    }
    
    // Initialize stored properties.
    self.name = name
    self.date = date
    self.photo = photo
    self.rating = rating
  }
  
  // MARK: NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(date, forKey: PropertyKey.date)
    aCoder.encode(photo, forKey: PropertyKey.photo)
    aCoder.encode(rating, forKey: PropertyKey.rating)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    // The name is required. If we cannot decode a name string, the initializer should fail.
    guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
      os_log("Unable to decode the name for a Event object.", log: OSLog.default, type: .debug)
      return nil
    }
    
    guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else {
      os_log("unable to decode the date for a Event object.", log: OSLog.default, type: .debug)
      return nil
    }
    
    // Because photo is an optional property of Event, just use conditional cast.
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
    
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
    
    
    
    // Must call designated initializer.
    self.init(name: name, date: date, photo: photo, rating: rating)
  }
  
}

































