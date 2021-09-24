//
//  NewsModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import Foundation

class NewsModel {
    
    let id: Int
    let title: String
    let description: String
    let imageUrlString: String
    let authorUserId: Int?
    let authorCommunityId: Int?
    var comments: [Comment]
    var likesUsers: [Int]
    var newsDate: Date
    
    init (id: Int, title: String, description: String, imageUrlString: String, authorUserId: Int?, authorCommunityId: Int? ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrlString = imageUrlString
        self.authorUserId = authorUserId
        self.authorCommunityId = authorCommunityId
//        self.likesCount = 0
        likesUsers = [133]
        comments = []
        newsDate = Date()
    }
}
