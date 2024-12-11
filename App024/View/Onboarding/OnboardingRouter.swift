//
//  OnboardingRouter.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import UIKit
import AppViewModel

final class OnboardingRouter: BaseRouter {
    static func showTabBarViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTabBarViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showPaymentViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePaymentViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.tabBarController?.tabBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
