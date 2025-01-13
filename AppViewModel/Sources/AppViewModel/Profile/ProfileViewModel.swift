//
//  ProfileViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import AppModel

public protocol IProfileViewModel {
    var profile: ProfileNavigationModel { get set }
}

public class ProfileViewModel: IProfileViewModel {

    private let profileService: IProfileService
    public var profile: ProfileNavigationModel

    public init(profileService: IProfileService, navigationModel: ProfileNavigationModel) {
        self.profileService = profileService
        self.profile = navigationModel
    }
}
