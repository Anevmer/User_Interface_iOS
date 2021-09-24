//
//  NewsTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 09.09.2021.
//

import Foundation

class NewsTableCellModel: Entity {
    
    let newId: Int
    let authorName: String
    let avatarImageName: String
    let imageUrlString: String
    let title: String
    let createDateString: String
    var likesCount: Int
    var isLiked: Bool
    var commentsCount: Int
    
    init(newsModel: NewsModel, myProfileId: Int) {
        self.newId = newsModel.id
        if let authorCommunityId = newsModel.authorCommunityId,
           let community = getCommunityWithId(communityId: authorCommunityId) {
            self.authorName = community.name
            self.avatarImageName = community.avatarName
        }
        else if let authorUserId = newsModel.authorUserId,
                let user = getProfileWithId(userId: authorUserId) {
            self.authorName = user.name + " " + user.surname
            self.avatarImageName = user.avatarName
        }
        else {
            authorName = "Аноним"
            avatarImageName = ""
        }
        isLiked = newsModel.likesUsers.contains(myProfileId)
        self.title = newsModel.title
        self.imageUrlString = newsModel.imageUrlString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM hh:mm"
        dateFormatter.locale = Locale(identifier: "ru")
        self.createDateString = dateFormatter.string(from: newsModel.newsDate)
        self.likesCount = newsModel.likesUsers.count
        self.commentsCount = newsModel.comments.count
        
    }
}
