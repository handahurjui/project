//
//  ExpensesManagerUITests.swift
//  ExpensesManagerUITests
//
//  Created by Andreea Hurjui on 06.04.2025.
//

import XCTest

final class ExpensesManagerUITests: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testDetailsPage() throws {
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.tables["tableView"].cells.element(boundBy: 0)
        firstCell.tap()
        
        
        var detailsView1 = app.otherElements["detailsView"]
        XCTAssertTrue(detailsView1.exists)
        
        var detailsView = app.otherElements["descriptionTextView"]
//        XCTAssertNotNil(detailsView.value)
        XCTAssertTrue(detailsView.exists)
        
        var titleView = app.otherElements["titleLabel"]
//        XCTAssertNotNil(titleView.value)
        XCTAssertTrue(titleView.exists)
        
        detailsView.swipeDown()
        detailsView = app.otherElements["detailsView"]
        XCTAssertFalse(detailsView.exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
