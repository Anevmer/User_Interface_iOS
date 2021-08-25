//
//  UserPhotoCollectionCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation

class UserPhotoCollectionCellModel: Entity {
    
    let photoName: String
    
    init (photoName: String) {
        self.photoName = photoName
    }
}
