//
//  UserProfile.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation

class UserProfile {
    
    var id: Int
    var name: String
    var surname: String
    var friendsId: [Int]
    var communitiesId: [Int]
    var avatarName: String
    var photoNames: [String]
    
    init (id: Int, name: String, surname: String, friendIds: [Int], communityIds: [Int], avatarName: String, photoNames: [String]) {
        self.id = id
        self.name = name
        self.surname = surname
        self.friendsId = friendIds
        self.communitiesId = communityIds
        self.avatarName = avatarName
        self.photoNames = photoNames
        
    }
}
