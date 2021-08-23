//
//  CommunityTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation

class CommunityTableCellModel: Entity {
    
    var fullName: String
    
    init(fullName: String) {
        self.fullName = fullName
    }
}
