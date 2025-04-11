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
        
        let detailsView = app.otherElements["detailsView"]
        XCTAssertTrue(detailsView.exists, "Custom view should exist on screen")
    }
    
    @MainActor
    func testEditPage() throws {
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.tables["tableView"].cells.element(boundBy: 0)
        // Swipe left to reveal the "Edit" action
        firstCell.swipeLeft()

        // Tap the "Edit" button
        let editButton = firstCell.buttons["Edit"]
        XCTAssertTrue(editButton.exists)
        editButton.tap()
        
        let editImageView = app.images["editImageView"]
        XCTAssertNotNil(editImageView.value)
        XCTAssertTrue(editImageView.exists)
        
        let editTitleLabel = app.textFields["editTitleLabel"]
        XCTAssertNotNil(editTitleLabel.value)
        XCTAssertTrue(editTitleLabel.exists)
        editTitleLabel.tap()
        let currentValue = editTitleLabel.value as? String ?? ""
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count)
        editTitleLabel.typeText(deleteString)
        editTitleLabel.typeText("Other title for test")
        XCTAssertEqual(editTitleLabel.value as? String, "Other title for test")
        
        var editDescriptionTextView = app.textViews["editDescriptionTextView"]
        XCTAssertNotNil(editDescriptionTextView.value)
        XCTAssertTrue(editDescriptionTextView.exists)
        editDescriptionTextView.swipeDown()
        editDescriptionTextView = app.textViews["editDescriptionTextView"]
        XCTAssertTrue(editDescriptionTextView.exists)
    }
    
    func testEditTitleDescriptionPage() {
        let app = XCUIApplication()
        app.launch()
        var historyPage = app.navigationBars["History"].exists
        XCTAssertTrue(historyPage)
        let firstCell = app.tables["tableView"].cells.element(boundBy: 0)
        firstCell.swipeLeft()
        let editButton = firstCell.buttons["Edit"]
        editButton.tap()
        
        let editTitleLabel = app.textFields["editTitleLabel"]
        editTitleLabel.tap()
        let currentValue = editTitleLabel.value as? String ?? ""
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: currentValue.count)
        editTitleLabel.typeText(deleteString)
        editTitleLabel.typeText("Other title for test")
        
        let imageView = app.images["editImageView"]
        XCTAssertTrue(imageView.exists, "image view should exist")
        imageView.tap()
        
        let saveButton = app.buttons["saveBtn"]
        saveButton.tap()
        
        historyPage = app.navigationBars["History"].exists
        XCTAssertTrue(historyPage)
    }
    
    func testAddPage() {
        let app = XCUIApplication()
        app.navigationBars["History"].buttons["Add"].tap()
        let saveButton = app.buttons["saveBtn"]
        XCTAssertTrue(saveButton.exists, "Save button should exist")
        saveButton.tap()
        let warningAlert = app.alerts["Save entry"]
        XCTAssertTrue(warningAlert.exists)
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
