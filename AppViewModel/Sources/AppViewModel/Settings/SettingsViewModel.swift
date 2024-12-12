//
//  SettingsViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel

public protocol ISettingsViewModel {
    var settingsItems: [SettingsSection] { get set }
    func loadData()
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService
    public var settingsItems: [SettingsSection] = []

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }

    public func loadData() {
        self.settingsItems = settingsService.getSettingsItems()
    }
}
