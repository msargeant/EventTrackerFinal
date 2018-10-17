//
//  EventTrackerFinalTests.swift
//  EventTrackerFinalTests
//
//  Created by Matthew Sargeant on 10/9/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import XCTest

@testable import EventTrackerFinal

class EventTrackerFinalTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    
  }
  
  override func tearDown() {
    super.tearDown()
    
  }
  
  func textExample() {
    
  }
  
  func testPerformanceExample() {
    self.measure {
      
    }
  }
  
  // MARK: Event Class Tests
  // Confirm that the Meal initializer returns a Meal object when passed valid parameters.
  func testMealInitializationSucceeds() {
    
    // Zero rating
    let zeroRatingEvent = Event.init(name: "Zero", date: "One", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingEvent)
    
    // Highest positive rating
    let positiveRatingEvent = Event.init(name: "Positive", date: "Negative", photo: nil, rating: 5)
    XCTAssertNotNil(positiveRatingEvent)
    
  }
  
  // Confirm that the Meal initializer returns nil when passed a negative rating or a n empty name.
  func testEventInitializationFails() {
    
    // Negative rating
    let negativeRatingEvent = Event.init(name: "Negative", date: "Positive", photo: nil, rating: -1)
    XCTAssertNil(negativeRatingEvent)
    
    // Rating exceeds maximum
    let largeRatingEvent = Event.init(name: "Large", date: "Small", photo: nil, rating: 6)
    XCTAssertNil(largeRatingEvent)
    
    // Empty String
    let emptyStringEvent = Event.init(name: "", date: "", photo: nil, rating: 0)
    XCTAssertNil(emptyStringEvent)
  }
  
  
}
