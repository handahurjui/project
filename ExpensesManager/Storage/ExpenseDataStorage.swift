//
//  ExpensesDataSource.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

import CoreData

struct ExpenseDataStorage {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = PersistenceCoreData.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    func saveEntry(title: String, description: String) -> Bool {
      
      try? mainContext.save()
      return true
    }
}
