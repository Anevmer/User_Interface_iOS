//
//  GetAllPhotosResponse.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.10.2021.
//

import Foundation
import ObjectMapper

class GetAllPhotosResponse: BaseResponse {
    
    // MARK: Public properties
    
    var items: [Photo]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        items       <- map["response.items"]
    }
}
