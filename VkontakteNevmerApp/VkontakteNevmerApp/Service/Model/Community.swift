//
//  Community.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation

class Community {
    
    var id: Int
    var name: String
    var avatarName: String
    var communityMembersId: [Int]
    
    init (id: Int, name: String, avatarName: String, membersId: [Int]) {
        self.id = id
        self.name = name
        self.avatarName = avatarName
        self.communityMembersId = membersId
    }
}
