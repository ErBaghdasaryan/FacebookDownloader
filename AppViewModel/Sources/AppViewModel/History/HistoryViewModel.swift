//
//  HistoryViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel

public protocol IHistoryViewModel {

}

public class HistoryViewModel: IHistoryViewModel {

    private let historyService: IHistoryService

    public init(historyService: IHistoryService) {
        self.historyService = historyService
    }
}
