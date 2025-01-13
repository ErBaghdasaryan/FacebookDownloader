//
//  ProfileNavigationModel.swift
//
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import Combine

public final class ProfileNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: ProfileModel
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: ProfileModel) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}
