//
//  InstructionPresentationModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import Foundation

public struct InstructionPresentationModel {
    public let stepImage: String
    public let phoneImage: String
    public let header: String
    public let description: String

    public init(stepImage: String, phoneImage: String, header: String, description: String) {
        self.stepImage = stepImage
        self.phoneImage = phoneImage
        self.header = header
        self.description = description
    }
}
