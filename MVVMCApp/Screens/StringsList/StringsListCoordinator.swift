//
//  StringsListCoordinator.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation
import UIKit

final class StringsListCoordinator: BaseCoordinator {

    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    override func start() {
        let viewModel = StringsListDefaultViewModel()
        let viewController = StringsListViewController(viewModel: viewModel)
        navigation.setViewControllers([viewController], animated: true)
    }
}
