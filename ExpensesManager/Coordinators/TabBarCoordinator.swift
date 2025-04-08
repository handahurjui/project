//
//  Untitled.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 07.04.2025.
//

import UIKit

class TabBarCoordinator {
    
    // MARK: Properties
    private let rootNavigationController: UINavigationController
    
    // MARK: Coordinator
    init(rootNavigationController: UINavigationController) { self.rootNavigationController = rootNavigationController }
    
    func start() {
        
        let scanVC = ScanViewController()
        let settingsVC = HistoryViewController()
        scanVC.tabBarItem = UITabBarItem(title: "Scan", image: UIImage(systemName: "camera"), selectedImage: UIImage(systemName: "camera.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "archivebox"), selectedImage: UIImage(systemName: "archivebox.fill"))
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [scanVC, settingsVC]
        
        rootNavigationController.setViewControllers([tabBarController], animated: false)
    }
}
