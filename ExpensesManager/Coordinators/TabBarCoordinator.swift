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
        
        let scanNC = UINavigationController()
        scanNC.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(systemName: "camera"), selectedImage: UIImage(systemName: "camera.fill"))
        let scanCoordinator = ScanCoordinator(rootNavigationController: scanNC, storage: storage)
        scanCoordinator.start()
        
        let historyNC = UINavigationController()
        historyNC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "archivebox"), selectedImage: UIImage(systemName: "archivebox.fill"))
        let historyCoordinator = HistoryCoordinator(rootNavigationController: historyNC, storage: storage)
        historyCoordinator.start()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [historyNC, scanNC]
        
        rootNavigationController.setViewControllers([tabBarController], animated: false)
    }
}
