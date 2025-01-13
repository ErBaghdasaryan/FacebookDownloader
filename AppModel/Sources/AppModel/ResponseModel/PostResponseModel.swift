//
//  PostResponseModel.swift
//
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation

public struct PostResponseModel: Codable {
    public let error: Bool
    public let messages: [String]
    public let data: PostDataModel
}

public struct PostDataModel: Codable {
    public let download: Download
}

// MARK: - Download
public struct Download: Codable {
    public let title: String?
    public let thumbnail: String?
    public let audio, video: String?
    public let duration: Int

    public init(title: String?, thumbnail: String?, audio: String?, video: String?, duration: Int) {
        self.title = title
        self.thumbnail = thumbnail
        self.audio = audio
        self.video = video
        self.duration = duration
    }
}
