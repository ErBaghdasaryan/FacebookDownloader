//
//  HomeAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppViewModel
import Swinject
import SwinjectAutoregistration

final class HomeAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IHomeViewModel.self, initializer: HomeViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IHomeService.self, initializer: HomeService.init)
    }
}
