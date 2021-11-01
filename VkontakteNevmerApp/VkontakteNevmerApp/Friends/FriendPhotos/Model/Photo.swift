//
//  Photo.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.10.2021.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    
    // MARK: Public properties

    var id: Int?
    var albumId: Int?
    var ownerId: Int?
    var sizes: [PhotoSize]?
    var text: String?
    var likes: LikeModel?
    
    // MARK: Init
    
    required init?(map: Map) {
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        id          <- map["id"]
        albumId     <- map["album_id"]
        ownerId     <- map["owner_id"]
        sizes       <- map["sizes"]
        text        <- map["text"]
        likes       <- map["likes"]
        
    }
}
