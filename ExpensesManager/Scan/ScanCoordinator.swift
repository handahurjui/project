//
//  ScanCoordinator.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

class ScanCoordinator: Coordinator {
    
    private let rootNavigationController: UINavigationController
    private var storage: Storage
    
    init(rootNavigationController: UINavigationController, storage: Storage) {
        self.rootNavigationController = rootNavigationController
        self.storage = storage
    }
    
    override func start() {
        super.addChildCoordinator(self)
        let scanVM = ScanViewModel(storage: storage)
        let scanVC = ScanViewController.instantiate()
        scanVC.viewModel = scanVM
        rootNavigationController.pushViewController(scanVC, animated: false)
    }
}
