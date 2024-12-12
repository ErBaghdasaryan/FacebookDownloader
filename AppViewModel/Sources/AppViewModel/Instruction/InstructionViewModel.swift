//
//  InstructionViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import Foundation
import AppModel

public protocol IInstructionViewModel {
    var instructionItems: [InstructionPresentationModel] { get set }
    func loadData()
}

public class InstructionViewModel: IInstructionViewModel {

    private let instructionService: IInstructionService

    public var instructionItems: [InstructionPresentationModel] = []

    public init(instructionService: IInstructionService) {
        self.instructionService = instructionService
    }

    public func loadData() {
        instructionItems = instructionService.getInstructionItems()
    }
}
