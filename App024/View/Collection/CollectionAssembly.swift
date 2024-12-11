//
//  CollectionAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppViewModel
import Swinject
import SwinjectAutoregistration

final class CollectionAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ICollectionViewModel.self, initializer: CollectionViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ICollectionService.self, initializer: CollectionService.init)
    }
}
