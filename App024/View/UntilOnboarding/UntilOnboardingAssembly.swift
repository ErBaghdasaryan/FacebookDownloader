//
//  UntilOnboardingAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import AppModel
import AppViewModel
import Swinject
import SwinjectAutoregistration

final class UntilOnboardingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IUntilOnboardingViewModel.self, initializer: UntilOnboardingViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IUntilOnboardingService.self, initializer: UntilOnboardingService.init)
    }
}
