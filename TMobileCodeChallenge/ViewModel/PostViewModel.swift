//
//  PostViewModel.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/26/20.
//

import UIKit


class PostViewModel {
    
    private(set) var post: Post
    
    let imageURLString: String
    let postTitle: String
    let postCommentsNum: Int
    let postScore: Int
    var ratio: CGFloat

    
    init(post: Post) {
        self.post = post
        postTitle = post.data.title
        postCommentsNum = post.data.num_comments
        imageURLString = post.data.thumbnail
        postScore = post.data.score
        ratio = 1.0
        if let height = post.data.thumbnail_height {
            if let width = post.data.thumbnail_width {
                ratio = CGFloat(height) / CGFloat(width)
            }
        }
    }
    
    static var isFetchingData = false
    
    static var after: String?
    
    static func fetchFeed(viewModel: inout [PostViewModel], pagination: Bool = false, afterlink: String = "") {
        var fetchedPostsViewModels = [PostViewModel]()
        let semaphore = DispatchSemaphore(value: 0)
        let feedRequest = FeedRequest(pagination: pagination, afterLink: afterlink)
        feedRequest.getPosts { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                fetchedPostsViewModels = posts.map({ return PostViewModel(post: $0 )})
                semaphore.signal()
            }
        }
        _ = semaphore.wait(timeout: .distantFuture)
        viewModel.append(contentsOf: fetchedPostsViewModels)
    }
    
}
