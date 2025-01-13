//
//  PostNavigationModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import Combine

public final class PostNavigationModel {
    public var activateSuccessSubject: PassthroughSubject<Bool, Never>
    public var model: Download
    
    public init(activateSuccessSubject: PassthroughSubject<Bool, Never>, model: Download) {
        self.activateSuccessSubject = activateSuccessSubject
        self.model = model
    }
}

