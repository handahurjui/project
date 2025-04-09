//
//  HistoryCoordinator.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

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
        let historyVC = HistoryViewController.instantiate()
        historyVC.viewModel = historyVM
        rootNavigationController.pushViewController(historyVC, animated: false)
    }
}
