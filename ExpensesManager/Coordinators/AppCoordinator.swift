//
//  AppCoordinator.swift
//  ExpensesManager
//
//  Created by Andreea Hurjui on 06.04.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let window: UIWindow?
    
    private var rootNavigationController = UINavigationController()
    
    // MARK: Coordinator
    init(window: UIWindow?) { self.window = window }
    
    override func start() {
        guard let window = window else { return }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let mainCoordinator = TabBarCoordinator(rootNavigationController: rootNavigationController)
        mainCoordinator.start()
    }
}
