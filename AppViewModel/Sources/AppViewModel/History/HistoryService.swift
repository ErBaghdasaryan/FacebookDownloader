//
//  HistoryService.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppModel
import SQLite

public protocol IHistoryService {
    func addRecently(_ model: RecentlyModel) throws -> RecentlyModel
    func getRecentlies() throws -> [RecentlyModel]
    func deleteRecently(byID id: Int) throws
    func deleteAllRecentlies() throws
}

public class HistoryService: IHistoryService {
    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    typealias Expression = SQLite.Expression

    public func addRecently(_ model: RecentlyModel) throws -> RecentlyModel {
        let db = try Connection("\(path)/db.sqlite3")
        let recentlies = Table("Recentlies")
        let idColumn = Expression<Int>("id")
        let titleColumn = Expression<String?>("title")
        let thumbnailColumn = Expression<String?>("thumbnail")
        let audioColumn = Expression<String?>("audio")
        let videoColumn = Expression<String?>("video")
        let durationColumn = Expression<Int>("duration")

        try db.run(recentlies.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(titleColumn)
            t.column(thumbnailColumn)
            t.column(audioColumn)
            t.column(videoColumn)
            t.column(durationColumn)
        })

        let rowId = try db.run(recentlies.insert(
            titleColumn <- model.title,
            thumbnailColumn <- model.thumbnail,
            audioColumn <- model.audio,
            videoColumn <- model.video,
            durationColumn <- model.duration
        ))

        return RecentlyModel(id: Int(rowId),
                             title: model.title,
                             thumbnail: model.thumbnail,
                             audio: model.audio,
                             video: model.video,
                             duration: model.duration)
    }

    public func getRecentlies() throws -> [RecentlyModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let recentlies = Table("Recentlies")
        let idColumn = Expression<Int>("id")
        let titleColumn = Expression<String?>("title")
        let thumbnailColumn = Expression<String?>("thumbnail")
        let audioColumn = Expression<String?>("audio")
        let videoColumn = Expression<String?>("video")
        let durationColumn = Expression<Int>("duration")

        var result: [RecentlyModel] = []

        for recently in try db.prepare(recentlies) {

            let fetchedRecently = RecentlyModel(id: recently[idColumn],
                                                title: recently[titleColumn],
                                                thumbnail: recently[thumbnailColumn],
                                                audio: recently[audioColumn],
                                                video: recently[videoColumn],
                                                duration: recently[durationColumn])

            result.append(fetchedRecently)
        }

        return result
    }

    public func deleteRecently(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let recentlies = Table("Recentlies")
        let idColumn = Expression<Int>("id")

        let recentlyToDelete = recentlies.filter(idColumn == id)
        try db.run(recentlyToDelete.delete())
    }

    public func deleteAllRecentlies() throws {
        let db = try Connection("\(path)/db.sqlite3")
        let recentlies = Table("Recentlies")
        try db.run(recentlies.delete())
    }
}
