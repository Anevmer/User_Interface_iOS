//
//  CommunityTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation

class CommunityTableCellModel: Entity {
    
    let fullName: String
    let avatarName: String
    let delegate: CommunityTableViewCellDelegate
    let id: Int
    
    init(community: Community, delegate: CommunityTableViewCellDelegate) {
        self.delegate = delegate
        id = community.id
        fullName = community.name
        avatarName = community.avatarName
    }
}
