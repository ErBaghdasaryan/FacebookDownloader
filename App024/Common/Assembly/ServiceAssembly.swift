//
//  ServiceAssembly.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import AppViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IKeychainService.self, initializer: KeychainService.init)
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
    }
}
