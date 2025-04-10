//
//  Expense+CoreDataClass.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import CoreData

protocol ExpenseContainerProtocol {
    var expenseNSManagedObject: NSManagedObject { set get }
    var expense: ExpenseModel? { get }
    var expenseDataView: ExpenseDataView? { get }
}

struct ExpenseContainer: ExpenseContainerProtocol {
    var expenseNSManagedObject: NSManagedObject {
        didSet {
            createExpenseModel(from: expenseNSManagedObject)
        }
    }
    var expenseDataView: ExpenseDataView? {
        get {
            return ExpenseDataView(expense: expense!)
        }
    }
    var expense: ExpenseModel?

    private mutating func createExpenseModel(from nsManagedObj: NSManagedObject) {
        if let id = nsManagedObj.value(forKey: "id"),
           let title = nsManagedObj.value(forKey: "title"),
           let description = nsManagedObj.value(forKey: "descriptionData"),
           let createdDate = nsManagedObj.value(forKey: "createdDate"),
           let image = nsManagedObj.value(forKey: "image") {
            let id = id as! UUID
            let title = "\(title)"
            let description = "\(description)"
            let createdDate = createdDate as! Date
            let image = image as! Data
            expense = ExpenseModel(id: id, title: title, descriptionData: description, createdDate: createdDate, image: image)
        }
    }

    init(nsManagedObject: NSManagedObject) {
        self.expenseNSManagedObject = nsManagedObject
        createExpenseModel(from: nsManagedObject)
    }
}
