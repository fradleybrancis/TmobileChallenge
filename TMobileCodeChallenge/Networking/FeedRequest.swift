//
//  FeedRequest.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/26/20.
//

import Foundation

class FeedRequest {
    
    let resourceURL: URL
    
    init(pagination: Bool, afterLink: String = "") {
        let resourceString = pagination ? "http://www.reddit.com/.json?after=\(afterLink)" : "http://www.reddit.com/.json"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getPosts(completion: @escaping (Result<[Post], FeedRequestError>) -> Void) {
        PostViewModel.isFetchingData = true
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            guard let feedJsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let feedResponses = try decoder.decode(Feed.self, from: feedJsonData)
                let posts = feedResponses.data.children
                PostViewModel.after = feedResponses.data.after
                completion(.success(posts))
            } catch {
                completion(.failure(.cannotDecodeData))
            }
            PostViewModel.isFetchingData = false
        }
        dataTask.resume()
    }
    
    enum FeedRequestError: Error {
        case noDataAvailable
        case cannotDecodeData
    }
}
