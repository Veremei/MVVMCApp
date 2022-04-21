//
//  LoginCoordinator.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation
import UIKit

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func loginFlowSuccess()
}

final class LoginCoordinator: BaseCoordinator {

    private let navigation: UINavigationController

    weak var coordinator : AppCoordinator!

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    override func start() {
        let viewModel = LoginDefaulViewModel()
        viewModel.coordinatorDelegate = self
        let viewController = LoginViewController(viewModel: viewModel)
        navigation.setViewControllers([viewController], animated: true)
    }
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {
    func loginFlowSuccess() {
        coordinator.loggedIn()
    }
}
