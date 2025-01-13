//
//  CollectionViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel

public protocol ICollectionViewModel {
    func loadData()
    var collections: [CollectionModel] { get set }
    func addCollection(model: CollectionModel)
    func deleteCollection(by id: Int)
}

public class CollectionViewModel: ICollectionViewModel {

    private let collectionService: ICollectionService
    public var collections: [CollectionModel] = []

    public init(collectionService: ICollectionService) {
        self.collectionService = collectionService
    }

    public func loadData() {
        do {
            collections = try self.collectionService.getCollections()
        } catch {
            print(error)
        }
    }

    public func addCollection(model: CollectionModel) {
        do {
            _ = try self.collectionService.addCollection(model)
        } catch {
            print(error)
        }
    }

    public func deleteCollection(by id: Int) {
        do {
           try self.collectionService.deleteCollection(byID: id)
        } catch {
            print(error)
        }
    }
}
