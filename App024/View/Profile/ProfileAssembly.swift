//
//  ProfileAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import AppViewModel
import AppModel
import Swinject
import SwinjectAutoregistration

final class ProfileAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IProfileViewModel.self, argument: ProfileNavigationModel.self, initializer: ProfileViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IProfileService.self, initializer: ProfileService.init)
    }
}
