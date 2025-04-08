//
//  Coordinator.swift
//  ExpensesManager
//
//  Created by Anda on 08.04.2025.
//

class Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    func start() {
        preconditionFailure("Override by concrete subclass.")
    }
}
