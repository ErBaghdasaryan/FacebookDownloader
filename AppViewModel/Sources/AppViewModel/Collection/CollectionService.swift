//
//  CollectionService.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppModel
import SQLite

public protocol ICollectionService {
    func addCollection(_ model: CollectionModel) throws -> CollectionModel
    func getCollections() throws -> [CollectionModel]
    func deleteCollection(byID id: Int) throws
}

public class CollectionService: ICollectionService {

    public init() { }

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    typealias Expression = SQLite.Expression

    public func addCollection(_ model: CollectionModel) throws -> CollectionModel {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")
        let titleColumn = Expression<String>("title")
        let mediaCountColumn = Expression<Int>("mediaCount")

        try db.run(collections.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(titleColumn)
            t.column(mediaCountColumn)
        })

        let rowId = try db.run(collections.insert(
            titleColumn <- model.title,
            mediaCountColumn <- model.mediaCount
        ))

        return CollectionModel(id: Int(rowId),
                               title: model.title,
                               mediaCount: model.mediaCount)
    }

    public func getCollections() throws -> [CollectionModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")
        let titleColumn = Expression<String>("title")
        let mediaCountColumn = Expression<Int>("mediaCount")

        var result: [CollectionModel] = []

        for collection in try db.prepare(collections) {

            let fetchedCollection = CollectionModel(id: collection[idColumn],
                                                    title: collection[titleColumn],
                                                    mediaCount: collection[mediaCountColumn])

            result.append(fetchedCollection)
        }

        return result
    }

    public func deleteCollection(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let collections = Table("Collections")
        let idColumn = Expression<Int>("id")

        let collectionToDelete = collections.filter(idColumn == id)
        try db.run(collectionToDelete.delete())
    }

}
