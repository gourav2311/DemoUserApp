//
//  UserViewScrollingTests.swift
//  DemoUsersAppUITests


import XCTest

final class UserViewScrollingTests: XCTestCase {

    private var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    
    func testScrollView() throws{
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        sleep(10) // Let data load
        XCTAssert(app.navigationBars.element.staticTexts["Users"].exists, "Users list view not loaded on screen")
     
        measure(metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric]) {
            app.swipeUp()
            app.swipeDown()
        }
    }

}
