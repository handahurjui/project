//
//  EditViewModel.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//
protocol EditViewModelDelegate {
    func showError(errorMessage: String)
}

class EditViewModel {
    
    // MARK: Properties
    private var storage: Storage
    var coordinator: EditViewCoordinatorDelegate?
    var delegate: EditViewModelDelegate?
    
    init(storage: Storage) {
        self.storage = storage
    }
}

extension EditViewModel {
    func editExpense(expenseContainer: ExpenseContainerProtocol) {
        storage.update(object: expenseContainer) { [weak self] (result) in
            switch result {
            case .success:
                self?.goBackToExpensesHistory()
            case .failure(let error):
                self?.delegate?.showError(errorMessage: error.localizedDescription)
            }
        }
    }
    
}

extension EditViewModel: EditViewCoordinatorDelegate {
    func goBackToExpensesHistory() {
        self.coordinator?.goBackToExpensesHistory()
    }
}
