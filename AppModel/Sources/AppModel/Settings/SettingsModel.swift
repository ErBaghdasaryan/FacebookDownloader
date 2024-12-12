//
//  SettingsModel.swift
//
//
//  Created by Er Baghdasaryan on 12.12.24.
//
import UIKit

public struct SettingsSection {
    public let title: String
    public let items: [SettingsItem]

    public init(title: String, items: [SettingsItem]) {
        self.title = title
        self.items = items
    }
}

public struct SettingsItem {
    public let title: String
    public let icon: UIImage?
    public let accessoryType: UITableViewCell.AccessoryType
//    let action: (() -> Void)?

    public init(title: String, icon: UIImage?, accessoryType: UITableViewCell.AccessoryType) {
        self.title = title
        self.icon = icon
        self.accessoryType = accessoryType
    }
}
