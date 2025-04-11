//
//  CoreDataTests.swift
//  ExpensesManagerTests
//
//  Created by Anda on 11.04.2025.
//

import XCTest
@testable import ExpensesManager

final class CoreDataTests: XCTestCase {
    
    var expenseDataStorage: ExpenseDataStorage!
    var coreDataStack: CoreDataStack!
    var managedObjects: [ExpenseContainerProtocol] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreDataStack = CoreDataStack()
        expenseDataStorage = ExpenseDataStorage(mainContext: coreDataStack.mainContext)
        loadExpenses()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_create_expense() {
        // given
        let expense = createExpense().first!
        expenseDataStorage.saveEntry(object: expense) { (_) in }
        
        // when
        loadExpenses()
        let lastAddedItem = managedObjects.last!
        // then
        XCTAssertEqual(lastAddedItem.expense?.title, expense.title)
    }
    
    private func loadExpenses() {
        self.managedObjects = []
        expenseDataStorage.fetchEntry { (result) in
            let nsObjects =  try! result.get()
            self.managedObjects.append(contentsOf: nsObjects.map { ExpenseContainer(nsManagedObject: $0) }
            )
        }
    }
    
    private func createExpense() -> [ExpenseModel] {
        let bundle = Bundle(for: CoreDataTests.self)
        guard let url = bundle.url(forResource: "imageTest", withExtension: "jpg"),
              let imageData = try? Data(contentsOf: url) else {
            XCTFail("Could not load test image")
            return []
        }
        guard let imageData = try? Data(contentsOf: url) else {
            XCTFail("Failed to load image data")
            return []
        }
        let expense1 = ExpenseModel(id: UUID(uuidString: "1"), title: "title 1", descriptionData: "description 1", createdDate: Date(), image: imageData)
        let expense2 = ExpenseModel(id: UUID(uuidString: "2"), title: "title 2", descriptionData: "description 2", createdDate: Date(), image: imageData)
        let expense3 = ExpenseModel(id: UUID(uuidString: "3"), title: "title 3", descriptionData: "description 3", createdDate: Date(), image: imageData)
        return [expense1, expense2, expense3]
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
