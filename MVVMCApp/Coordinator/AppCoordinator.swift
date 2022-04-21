//
//  AppFlowCoordinator.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {

    let window: UIWindow?

    lazy var rootViewController: UINavigationController = {
        return UINavigationController()
    }()

    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        guard let window = window else { return }
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        buildLogin()
    }

    private func buildLogin() {
        let loginCoordinator = LoginCoordinator(navigation: rootViewController)
        loginCoordinator.coordinator = self
        appendChild(coordinator: loginCoordinator)
        loginCoordinator.start()
    }

    private func buildList() {
        let listCoordinator = StringsListCoordinator(navigation: rootViewController)
//        listCoordinator.coordinator = self
        appendChild(coordinator: listCoordinator)
        listCoordinator.start()
    }
}

extension AppCoordinator {
    func loggedIn() {
        removeAllCoordinators()
        buildList()
    }
}

