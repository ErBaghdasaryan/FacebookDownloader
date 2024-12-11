//
//  Setupable.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}

