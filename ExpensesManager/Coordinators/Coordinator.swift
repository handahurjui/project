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
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("There is no coordinator \(coordinator)")
        }
    }
}

extension Coordinator: Equatable {
    
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool { return lhs === rhs }
    
}
