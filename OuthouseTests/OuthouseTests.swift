//
//  OuthouseTests.swift
//  OuthouseTests
//
//  Created by Derek May on 8/20/16.
//  Copyright © 2016 Derek May. All rights reserved.
//

import XCTest
@testable import Outhouse

class OuthouseTests: XCTestCase {
    var splashVC: ShowSplashScreenViewController!
    var eventsVC: UpcomingEventsTableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        splashVC = storyboard.instantiateInitialViewController() as! ShowSplashScreenViewController
        //eventsVC = storyboard.instantiateViewControllerWithIdentifier(<#T##identifier: String##String#>)("Upcoming Events")
   }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPercentageCalculator() {
        XCTAssert(true)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
