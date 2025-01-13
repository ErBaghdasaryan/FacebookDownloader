//
//  PostViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import Foundation
import AppModel

public protocol IPostViewModel {
    var post: Download { get set }
}

public class PostViewModel: IPostViewModel {

    private let postService: IPostService
    public var post: Download

    public init(postService: IPostService, navigationModel: PostNavigationModel) {
        self.postService = postService
        self.post = navigationModel.model
    }
}
