//
//  String.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var boolValue: Bool? {
        switch self {
        case "0":
            return false
        case "1":
            return true
        default:
            return nil
        }
    }
}

public extension String {
    var replacedString: String {
        self.replacingOccurrences(of: "/", with: "-")
    }
}

public extension String {
    func extractInt() -> Int? {
        let cleanedString = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return Int(cleanedString)
    }
}
