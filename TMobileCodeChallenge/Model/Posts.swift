//
//  Posts.swift
//  TMobileCodeChallenge
//
//  Created by Rave BizzDev on 9/26/20.
//

import Foundation

struct Feed: Decodable {
    let data: FeedInfo
}

struct FeedInfo: Decodable {
    let children: [Post]
    let after: String?
}

struct Post: Decodable {
    let data: PostInfo
}

struct PostInfo: Decodable {
    let title: String
    let thumbnail: String
    let thumbnail_height: Int?
    let thumbnail_width: Int?
    let score: Int
    let num_comments: Int
}


