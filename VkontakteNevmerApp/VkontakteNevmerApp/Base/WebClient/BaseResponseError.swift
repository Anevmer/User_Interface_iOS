//
//  BaseResponseError.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import Foundation
import ObjectMapper

class BaseResponseError: Mappable {
    
    // MARK: Public properties
    
    var message: String?
    var code: Int?
    
    // MARK: Mappable
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        message <- map["message"]
        code    <- map["code"]
    }
}
