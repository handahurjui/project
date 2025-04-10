//
//  HistoryViewModel.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import UIKit

protocol HistoryViewModelDelegate {
    func refreshScreen()
    func showError(errorMessage: String)
}

class HistoryViewModel {
        
    // MARK: Properties
    var storage: Storage
    private var managedObjects: [ExpenseContainer]? {
        didSet {
            viewDelegate?.refreshScreen()
        }
    }
    var viewDelegate: HistoryViewModelDelegate?
    var coordinator: HistoryCoordinatorDelegate?
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func loadExpenses() {
        storage.fetchEntry { [weak self] (result) in
            switch result {
            case .success(let managedObjects):
                self?.managedObjects =  managedObjects.compactMap { ExpenseContainer(nsManagedObject: $0)
                }
            case .failure(let error):
                self?.viewDelegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
}

extension HistoryViewModel {
    // Data Source
    func numberOfRows() -> Int { return managedObjects!.count }
    
    func cellDataFor(row: Int) -> ExpenseDataView {
        return  managedObjects![row].expenseDataView!
    }
    // Delegate events
    func didSelectRow(_ row: Int) {
        let item =  managedObjects![row].expenseDataView!
        coordinator?.goToDetailsPage(expenseDataView: item)
    }
    
    func addBtnTapped(controller: UIViewController) {
        coordinator?.goToAddNewItem(controller: controller)
    }
    
    func editBtnTapped(row: IndexPath, controller: UIViewController) {
        let item = managedObjects![row.row]
        coordinator?.goToEditVC(managedObject: item, controller: controller)
    }
}
