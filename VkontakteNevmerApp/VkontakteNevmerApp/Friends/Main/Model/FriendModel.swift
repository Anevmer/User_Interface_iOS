//
//  FriendModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import ObjectMapper

class FriendModel: Mappable {
    
    // MARK: Public properties

    var firstName: String?
    var lastName: String?
    var id: Int?
    var domain: String?
    var photoUrl: String?
    var online: Int?
    var mobileOnline: Int?
    var birthday: String?
    
    // MARK: Init
    
    required init?(map: Map) {
    }
    
    // MARK: Mapping
    
    func mapping(map: Map) {
        firstName       <- map["first_name"]
        lastName        <- map["last_name"]
        id              <- map["id"]
        domain          <- map["domain"]
        photoUrl        <- map["photo_50"]
        mobileOnline    <- map["online_mobile"]
        online          <- map["online"]
        birthday        <- map["bdate"]
    }
}
