//
//  Expense+CoreDataProperties.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation
import CoreData

extension Expense {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var descriptionData: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
}

extension Expense: Identifiable { }

extension Expense: ExpenseProtocol { }
