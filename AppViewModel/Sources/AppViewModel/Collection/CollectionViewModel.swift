//
//  CollectionViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import Foundation
import AppModel

public protocol ICollectionViewModel {

}

public class CollectionViewModel: ICollectionViewModel {

    private let collectionService: ICollectionService

    public init(collectionService: ICollectionService) {
        self.collectionService = collectionService
    }
}
