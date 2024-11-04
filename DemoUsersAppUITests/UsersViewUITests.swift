//
//  UserCardViewUITests.swift
//  DemoUsersAppUITests

import XCTest
import SwiftUI
@testable import DemoUsersApp
final class UsersViewUITests: XCTestCase {
    private var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    override class func tearDown() {
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  
    func testNavigationToDetailView() throws {
                // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(10) // Let data load
        app.collectionViews.element(boundBy: 0).cells.element(boundBy: 0).tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(app.navigationBars.element.staticTexts["User Details"].exists, "Users Details not loaded on screen")
    }
    
    func testNavigationDetails() throws {
//        let app = XCUIApplication()
//        app.launch()
//        sleep(20)
        XCTAssert(app.navigationBars.element.staticTexts["Users"].exists, "Users list view not loaded on screen")
    }

}


