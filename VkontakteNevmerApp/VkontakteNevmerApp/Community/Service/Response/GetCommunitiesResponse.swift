//
//  GetCommunitiesResponse.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import ObjectMapper

class GetCommunitiesResponse: BaseResponse {
    
    // MARK: Public properties
    
    var items: [CommunityModel]?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        items       <- map["response.items"]
    }
}
