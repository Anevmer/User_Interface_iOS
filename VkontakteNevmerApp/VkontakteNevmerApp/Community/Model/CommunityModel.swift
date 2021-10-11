//
//  CommunityModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import ObjectMapper

class CommunityModel: Mappable {
    
    // MARK: Public properties

    var name: String?
    var screenName: String?
    var id: Int?
    var photoUrl: String?
    var status: String?
    var verified: Int?
    
    // MARK: Init
    
    required init?(map: Map) {
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        name                <- map["name"]
        screenName          <- map["screen_name"]
        id                  <- map["id"]
        photoUrl            <- map["photo_50"]
        status              <- map["status"]
        verified            <- map["verified"]
    }
}
