//
//  PhotoSize.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.10.2021.
//

import Foundation
import ObjectMapper

class PhotoSize: Mappable {
    
    // MARK: Public properties

    var url: Int?
    var width: Int?
    var height: Int?
    var type: String?
    
    // MARK: Init
    
    required init?(map: Map) {
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        url         <- map["src"]
        width       <- map["width"]
        height      <- map["height"]
        type        <- map["type"]
    }
}
