//
//  NewsModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import Foundation

class NewsModel {
    
    let title: String
    let description: String
    let imageUrlString: String
    let authorUserId: Int?
    let authorCommunityId: Int?
    var comments: [Comment]
    var likesCount: Int
    var newsDate: Date
    
    init (title: String, description: String, imageUrlString: String, authorUserId: Int?, authorCommunityId: Int? ) {
        self.title = title
        self.description = description
        self.imageUrlString = imageUrlString
        self.authorUserId = authorUserId
        self.authorCommunityId = authorCommunityId
        self.likesCount = 0
        comments = []
        newsDate = Date()
    }
}
