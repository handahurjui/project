//
//  ScanCoordinator.swift
//  ExpensesManager
//
//  Created by Anda on 10.04.2025.
//

import UIKit

protocol ScanCoordinatorDelegate {
    func popVC()
}

class ScanCoordinator: Coordinator {
    
    private let rootNavigationController: UINavigationController
    private var storage: Storage
    var didFinishAddingFlow: (() -> Void)?
    
    init(rootNavigationController: UINavigationController, storage: Storage) {
        self.rootNavigationController = rootNavigationController
        self.storage = storage
    }
    
    override func start() {
        super.addChildCoordinator(self)
        let scanVM = ScanViewModel(storage: storage)
        scanVM.coodinator = self
        let scanVC = ScanViewController.instantiate()
        scanVC.viewModel = scanVM
        rootNavigationController.pushViewController(scanVC, animated: false)
    }
}
extension ScanCoordinator: ScanCoordinatorDelegate {
    func popVC() {
        if let changeTab = didFinishAddingFlow {
            changeTab()
        }
    }
}
