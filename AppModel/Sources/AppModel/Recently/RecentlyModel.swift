//
//  RecentlyModel.swift
//
//
//  Created by Er Baghdasaryan on 10.01.25.
//

import UIKit

public struct RecentlyModel {
    public let id: Int?
    public let title: String?
    public let thumbnail: String?
    public let audio, video: String?
    public let duration: Int

    public init(id: Int? = nil, title: String?, thumbnail: String?, audio: String?, video: String?, duration: Int) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
        self.audio = audio
        self.video = video
        self.duration = duration
    }
}
