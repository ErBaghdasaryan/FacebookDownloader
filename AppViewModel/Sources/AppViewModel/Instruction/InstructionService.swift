//
//  InstructionService.swift
//  
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import UIKit
import AppModel

public protocol IInstructionService {
    func getInstructionItems() -> [InstructionPresentationModel]
}

public class InstructionService: IInstructionService {
    public init() { }

    public func getInstructionItems() -> [InstructionPresentationModel] {
        [
            InstructionPresentationModel(stepImage: "stepImage1",
                                         phoneImage: "step1",
                                         header: "First step",
                                         description: "Open Facebook"),
            InstructionPresentationModel(stepImage: "stepImage2",
                                         phoneImage: "step2",
                                         header: "Second step",
                                         description: "Copy the link of the post"),
            InstructionPresentationModel(stepImage: "stepImage3",
                                         phoneImage: "step3",
                                         header: "Third step",
                                         description: "Open our app and paste the link"),
        ]
    }
}
