//
//  PostRouter.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import UIKit
import AppViewModel
import AppModel

final class PostRouter: BaseRouter {

    static func showPaymentViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePaymentViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}

