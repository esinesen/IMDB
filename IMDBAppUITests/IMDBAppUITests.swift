//
//  IMDBAppUITests.swift
//  IMDBAppUITests
//
//  Created by Esin Esen on 26.04.2022.
//

import XCTest

class IMDBAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        func testExample() throws {

        let app = XCUIApplication()
        app.launch()

            //tableView to details
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["The Outfit"]/*[[".cells.staticTexts[\"The Outfit\"]",".staticTexts[\"The Outfit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            let loveButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["love"]/*[[".cells.buttons[\"love\"]",".buttons[\"love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            loveButton.tap()
            
            //collectionView to details
            let collectionViewsQuery = app.collectionViews
            let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
            element.tap()
            
            //return back
            let homeNavigationBar = app.navigationBars["Home"]
            homeNavigationBar.buttons["Back"].tap()
            homeNavigationBar.buttons["Home"].tap()

            
            //searching and details
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .searchField).element.tap()
            tablesQuery.staticTexts["The Northman"].tap()
            tablesQuery.buttons["love"].tap()
            app.collectionViews.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
            app.navigationBars["Home"].buttons["Back"].tap()
            app.navigationBars["Home"].buttons["Home"].tap()

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
