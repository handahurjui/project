//
//  HistoryCoordinator.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

protocol HistoryCoordinatorDelegate {
    func goToDetailsPage(expenseDataView: ExpenseDataView)
}

class HistoryCoordinator: Coordinator {
    
    private let rootNavigationController: UINavigationController
    private var storage: Storage
    
    init(rootNavigationController: UINavigationController, storage: Storage) {
        self.rootNavigationController = rootNavigationController
        self.storage = storage
    }
    
    override func start() {
        super.addChildCoordinator(self)
        let historyVM = HistoryViewModel(storage: storage)
        historyVM.coordinator = self
        let historyVC = HistoryViewController.instantiate()
        historyVC.viewModel = historyVM
        rootNavigationController.pushViewController(historyVC, animated: false)
    }
}

// MARK: HistoryViewModel Callbacks
extension HistoryCoordinator: HistoryCoordinatorDelegate {
    func goToDetailsPage(expenseDataView: ExpenseDataView) {
        let vc = DetailsViewController.instantiate()
        vc.expenseDataView = expenseDataView
        rootNavigationController.pushViewController(vc, animated: true)
    }
    
}
