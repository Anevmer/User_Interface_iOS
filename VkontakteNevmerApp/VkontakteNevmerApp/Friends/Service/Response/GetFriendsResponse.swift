//
//  GetFriendsResponse.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import Foundation
import ObjectMapper

class GetFriendsResponse: BaseResponse {
    
    // MARK: Public properties
    
    var items: [FriendModel]?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        items       <- map["response.items"]
    }
}
