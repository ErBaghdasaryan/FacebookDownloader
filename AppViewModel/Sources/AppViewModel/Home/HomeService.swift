//
//  HomeService.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppModel
import SQLite

public protocol IHomeService {
    func addRecently(_ model: RecentlyModel) throws -> RecentlyModel
}

public class HomeService: IHomeService {
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
}
