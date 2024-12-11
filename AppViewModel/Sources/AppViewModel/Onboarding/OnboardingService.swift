//
//  OnboardingService.swift
//  
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import AppModel

public protocol IOnboardingService {
    func getOnboardingItems() -> [OnboardingPresentationModel]
}

public class OnboardingService: IOnboardingService {
    public init() { }

    public func getOnboardingItems() -> [OnboardingPresentationModel] {
        [
            OnboardingPresentationModel(image: "onboarding1",
                                        header: "Save Facebook content",
                                        description: "The best quality with a Single Tap"),
            OnboardingPresentationModel(image: "onboarding2",
                                        header: "Save your friends Story",
                                        description: "Download it and collect it"),
            OnboardingPresentationModel(image: "onboarding3",
                                        header: "Organize with Collection",
                                        description: "Save and sort with custom folders"),
            OnboardingPresentationModel(image: "onboarding4",
                                        header: "Share your feedback",
                                        description: "Rate our app in the AppStore."),
        ]
    }
}
