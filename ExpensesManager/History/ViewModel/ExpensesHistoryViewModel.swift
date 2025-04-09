//
//  ExpensesHistoryViewModel.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import Foundation

protocol ExpensesHistoryViewModelProtocol: ObservableObject {
    var state: ScreenState<[ExpenseModel], Error> { get }
    var storage: Storage { get }
    func loadExpenses()
}

class ExpensesHistoryViewModel: ExpensesHistoryViewModelProtocol {
    
    //MARK: Properties
    var storage: Storage
    @Published var state: ScreenState<[ExpenseModel], Error> = .idle
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func loadExpenses() {
        self.state = .loading
        storage.fetchEntry { [weak self] (result) in
            switch result {
            case .success(let managedObjects):
                let expenseContainers: [ExpenseContainerProtocol] =  managedObjects.compactMap { ExpenseContainer(nsManagedObject: $0)
                }
                let expense = expenseContainers.compactMap { $0.expense }
                self?.state =  .loaded(expense)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}

enum ScreenState<Success, Failure> {
    case loading
    case idle
    case loaded(Success)
    case failed(Failure)
    
    var isFailure: Bool {
        switch self {
        case .failed:
            return true
        default:
            return false
        }
    }
}
