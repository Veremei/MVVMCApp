//
//  Coordinator.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func appendChild(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func removeAllCoordinators() {
        childCoordinators.removeAll()
    }
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    func start() {}
}
