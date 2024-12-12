//
//  InstructionAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import Foundation
import AppViewModel
import Swinject
import SwinjectAutoregistration

final class InstructionAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IInstructionViewModel.self, initializer: InstructionViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IInstructionService.self, initializer: InstructionService.init)
    }
}
