//
//  CommunityTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation

class CommunityTableCellModel: Entity {
    
    var fullName: String
    var avatarName: String
    
    init(community: Community) {
        fullName = community.name
        avatarName = community.avatarName
    }
}
