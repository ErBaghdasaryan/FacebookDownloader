//
//  PostAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import AppViewModel
import AppModel
import Swinject
import SwinjectAutoregistration

final class PostAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IPostViewModel.self, argument: PostNavigationModel.self, initializer: PostViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IPostService.self, initializer: PostService.init)
    }
}
