//
//  HistoryCoordinator.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

protocol HistoryCoordinatorDelegate {
    func goToDetailsPage(expenseDataView: ExpenseDataView)
    func goToAddNewItem(controller: UIViewController)
    func goToEditVC(managedObject: ExpenseContainerProtocol, controller: UIViewController)
    func popVC()
}

class HistoryCoordinator: Coordinator {
    
    private let rootNavigationController: UINavigationController
    private var storage: Storage
    var didTappedAddNewItemFlow: (() -> Void)?
    
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
    func goToEditVC(managedObject: ExpenseContainerProtocol, controller: UIViewController) {
        let vc = EditViewController.instantiate()
        vc.expenseContainer = managedObject as? ExpenseContainer
        let vm = EditViewModel(storage: storage)
        vm.coordinator = self
        vc.viewModel = vm
        rootNavigationController.pushViewController(vc, animated: true)
    }
    
    func goToAddNewItem(controller: UIViewController) {
        if let changeFlow = didTappedAddNewItemFlow {
            changeFlow()
        }
    }
    
    func goToDetailsPage(expenseDataView: ExpenseDataView) {
        let vc = DetailsViewController.instantiate()
        vc.expenseDataView = expenseDataView
        rootNavigationController.pushViewController(vc, animated: true)
    }
    
    func popVC() {
        rootNavigationController.popViewController(animated: true)
    }
}
