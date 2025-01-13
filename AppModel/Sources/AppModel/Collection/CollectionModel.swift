//
//  CollectionModel.swift
//  
//
//  Created by Er Baghdasaryan on 10.01.25.
//

import UIKit

public struct CollectionModel {
    public let id: Int?
    public let title: String
    public let mediaCount: Int

    public init(id: Int? = nil, title: String, mediaCount: Int) {
        self.id = id
        self.title = title
        self.mediaCount = mediaCount
    }
}
