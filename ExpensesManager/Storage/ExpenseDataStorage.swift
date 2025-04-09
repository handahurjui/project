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
    
    func saveEntry(title: String, description: String, image: UIImage, completion: @escaping (Result<Bool, Error>) -> ()) {
        let newItem = Expense(context: mainContext)
        newItem.title = title
        newItem.createdDate = Date()
        newItem.descriptionData = description
        newItem.id = UUID()
        newItem.image = image.toData()
        saveContext{ result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
    
    func saveContext(completion: @escaping (Result<Bool, Error>) -> ()) {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
                completion(.success(true))
            } catch {
                if let error = error as NSError? {
                    completion(.failure(error))
                }
            }
        }
    }
}
