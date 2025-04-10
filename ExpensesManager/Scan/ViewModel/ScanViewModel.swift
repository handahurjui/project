//
//  ScanViewModel.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation

class ScanViewModel {
    var storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
        
    func saveData(expense: ExpenseModel) {
        storage.saveEntry(object: expense) { result in
            switch result {
            case .success(_):
                print("Successful saved")
            case .failure(_):
                print("Clould not save")
            }
        }
    }
}
