//
//  ExpensesDataSource.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

import CoreData

protocol Storage {
    func fetchEntry<T:NSManagedObject>(completion: @escaping (Result<[T], Error>) -> ())
    func saveEntry<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ())
    func update<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ())
}

struct StorageError {
    static let errorSaveEntry = NSError(domain: "Could not save to storage", code: 1, userInfo: nil)
    static let errorFetchEntry = NSError(domain: "Could not fetch from storage", code: 2, userInfo: nil)
    static let errorUpdateEntry = NSError(domain: "Could update storage", code: 4, userInfo: nil)
}

struct ExpenseDataStorage: Storage {
    
    let mainContext: NSManagedObjectContext
    
    init(mainContext: NSManagedObjectContext = PersistenceCoreData.shared.mainContext) {
        self.mainContext = mainContext
    }
    
    func fetchEntry<T:NSManagedObject>(completion: @escaping (Result<[T], Error>) -> ()) {
        let fetchRequest = NSFetchRequest<T>(entityName: "Expense")
        
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
    
    func saveEntry<T>(object: T, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let expense = object as? ExpenseModel else {
            completion(.failure(StorageError.errorSaveEntry))
            return
        }
        let newItem = Expense(context: mainContext)
        newItem.title = expense.title
        newItem.id = UUID()
        newItem.descriptionData = expense.descriptionData
        newItem.createdDate = Date()
        newItem.image = expense.image
        
        saveContext{ result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update<T>(object: T, completion: @escaping (Result<Bool, any Error>) -> ()) {
        guard let expenseContainer = object as? ExpenseContainer,
              let expenseModel = expenseContainer.expense else {
            completion(.failure(StorageError.errorUpdateEntry))
            return
        }
        let nsManagedObject = expenseContainer.expenseNSManagedObject
        nsManagedObject.setValue(expenseModel.title, forKey: "title")
        nsManagedObject.setValue(expenseModel.descriptionData, forKey: "descriptionData")
        saveContext{ result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
