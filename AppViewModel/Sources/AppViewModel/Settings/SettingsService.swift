//
//  SettingsService.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppModel

public protocol ISettingsService {
    func getSettingsItems() -> [SettingsSection]
}

public class SettingsService: ISettingsService {
    public init() { }

    public func getSettingsItems() -> [SettingsSection] {
        [
            SettingsSection(title: "Purchases", items: [
                SettingsItem(title: "Upgrade plan",
                             icon: UIImage(named: "upgradePlan"),
                             accessoryType: .disclosureIndicator),
                SettingsItem(title: "Restore purchases",
                             icon: UIImage(named: "restorePurchase"),
                             accessoryType: .disclosureIndicator),
            ]),
            SettingsSection(title: "Actions", items: [
                SettingsItem(title: "Upgrade plan",
                             icon: UIImage(named: "upgradePlan"),
                             accessoryType: .none),
                SettingsItem(title: "Clear cache",
                             icon: UIImage(named: "clearCache"),
                             accessoryType: .disclosureIndicator),
            ]),
            SettingsSection(title: "Support us", items: [
                SettingsItem(title: "Rate app",
                             icon: UIImage(named: "rateApp"),
                             accessoryType: .disclosureIndicator),
                SettingsItem(title: "Share with friends",
                             icon: UIImage(named: "shareWith"),
                             accessoryType: .disclosureIndicator),
            ]),
            SettingsSection(title: "Info & legal", items: [
                SettingsItem(title: "Contact us",
                             icon: UIImage(named: "contactUs"),
                             accessoryType: .disclosureIndicator),
                SettingsItem(title: "Privacy Policy",
                             icon: UIImage(named: "privacyPolicy"),
                             accessoryType: .disclosureIndicator),
                SettingsItem(title: "Usage Policy",
                             icon: UIImage(named: "usagePolicy"),
                             accessoryType: .disclosureIndicator),
            ]),
        ]
    }

}
