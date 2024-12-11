//
//  UntilOnboardingRouter.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import UIKit
import AppViewModel

final class UntilOnboardingRouter: BaseRouter {

    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showOnboardingViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeOnboardingViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
