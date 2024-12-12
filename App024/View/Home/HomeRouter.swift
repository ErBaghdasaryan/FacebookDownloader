//
//  HomeRouter.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import UIKit
import AppViewModel

final class HomeRouter: BaseRouter {

    static func showInstructionViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeInstructionViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showPaymentViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePaymentViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
