//
//  FriendTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation
 
class FriendTableCellModel: Entity {
    
    let fullName: String
    let imageName: String?
    let user: UserProfile
    
    init (user: UserProfile) {
        self.user = user
        self.fullName = user.name + " " + user.surname
        self.imageName = user.avatarName == "" ? nil : user.avatarName
    }
}
