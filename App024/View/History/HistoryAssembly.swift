//
//  HistoryAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppViewModel
import Swinject
import SwinjectAutoregistration

final class HistoryAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IHistoryViewModel.self, initializer: HistoryViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IHistoryService.self, initializer: HistoryService.init)
    }
}
