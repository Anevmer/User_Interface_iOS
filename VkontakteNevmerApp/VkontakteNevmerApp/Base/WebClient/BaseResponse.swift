//
//  BaseResponse.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    
    // MARK: Public properties
    
    var isSuccess: Bool?
    var error: BaseResponseError?
    
    // MARK: Mappable
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        isSuccess <- map["isSuccess"]
        error     <- map["error"]
    }
}
