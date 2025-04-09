//
//  Untitled.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: Properties
    private let rootNavigationController: UINavigationController
    
    // MARK: Coordinator
    init(rootNavigationController: UINavigationController) { self.rootNavigationController = rootNavigationController }
    
    override func start() {
        
        let storage = ExpenseDataStorage()
        let scanVM = ScanViewModel(storage: storage as? SaveProtocol ?? storage)
        let scanVC = ScanViewController.instantiate()
        scanVC.viewModel = scanVM
        scanVC.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(systemName: "camera"), selectedImage: UIImage(systemName: "camera.fill"))
        
        let historyVM = HistoryViewModel(storage: storage)
        let historyVC = HistoryViewController.instantiate()
        historyVC.viewModel = historyVM
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "archivebox"), selectedImage: UIImage(systemName: "archivebox.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [historyVC, scanVC]
        
        rootNavigationController.setViewControllers([tabBarController], animated: false)
    }
}
