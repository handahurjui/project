//
//  CoreDataStack.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

import Foundation
import CoreData

struct PersistenceCoreData {
  static let shared = PersistenceCoreData()

    let container: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "ExpenseManager")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.name = "UIViewContext"
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mainContext = container.viewContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
