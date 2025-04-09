//
//  ExpensesDataSource.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

import CoreData
import UIKit

struct ExpenseDataStorage {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = PersistenceCoreData.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    func saveEntry(title: String, description: String, image: UIImage) -> Bool {
        let newItem = Expense(context: mainContext)
        newItem.title = title
        newItem.createdDate = Date()
        newItem.descriptionData = description
        newItem.id = UUID()
        newItem.image = image.toData()
        saveContext()
      return true
    }
    
    func fetchEntry(completion: @escaping (Result<[Expense]?, Error>) -> ()) {
        let fetchRequest = NSFetchRequest<Expense>(entityName: "Expense")
        
        do {
            let item = try mainContext.fetch(fetchRequest)
            completion(.success(item))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
}
