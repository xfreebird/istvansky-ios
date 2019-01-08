//
//  Istvan_SkyUITests.swift
//  Istvan SkyUITests
//
//  Created by Nicolae Ghimbovschi on 1/8/19.
//  Copyright © 2019 GMBN. All rights reserved.
//

import XCTest

class Istvan_SkyUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Home"].tap()
        snapshot("00Home")
        tabBarsQuery.buttons["Healing Music"].tap()
        snapshot("01Music")
        tabBarsQuery.buttons["Tour Dates"].tap()
        snapshot("02Tour")
        tabBarsQuery.buttons["Donate"].tap()
        snapshot("03Donate")
        tabBarsQuery.buttons["More"].tap()
        snapshot("04More")
    }

}
