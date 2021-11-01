//
//  LikeModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.10.2021.
//

import Foundation
import ObjectMapper

class LikeModel: Mappable {
    
    // MARK: Public properties

    var userLikes: Int?
    var count: Int?
    
    // MARK: Init
    
    required init?(map: Map) {
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        userLikes   <- map["user_likes"]
        count       <- map["count"]
    }
}
