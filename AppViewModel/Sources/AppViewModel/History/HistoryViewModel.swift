//
//  HistoryViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel
import Combine

public protocol IHistoryViewModel {
    func loadData()
    var recentlies: [RecentlyModel] { get set }
    func deleteFile(for id: Int)
    func deleteAllHistory()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
}

public class HistoryViewModel: IHistoryViewModel {

    private let historyService: IHistoryService
    public var recentlies: [RecentlyModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(historyService: IHistoryService) {
        self.historyService = historyService
    }

    public func loadData() {
        do {
            recentlies = try self.historyService.getRecentlies()
        } catch {
            print(error)
        }
    }

    public func deleteFile(for id: Int) {
        do {
            try self.historyService.deleteRecently(byID: id)
        } catch {
            print(error)
        }
    }

    public func deleteAllHistory() {
        do {
            try self.historyService.deleteAllRecentlies()
        } catch {
            print(error)
        }
    }
}
