//
//  ReusableVIew.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit

protocol IReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension IReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
