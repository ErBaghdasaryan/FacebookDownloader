//
//  BaseRouter.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import Combine
import AppViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
