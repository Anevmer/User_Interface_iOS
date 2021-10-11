//
//  FriendsService.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import Foundation
import Alamofire

protocol FriendsService {
    
    func getFriends(_ completion: @escaping (_ friends: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request?
    
}
