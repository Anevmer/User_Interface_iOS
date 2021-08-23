//
//  FriendTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation
 
class FriendTableCellModel: Entity {
    
    var fullName: String
    var imageName: String?
    
    init(fullName: String, imageName: String? = nil) {
        self.fullName = fullName
        self.imageName = imageName
    }
}
