//
//  FriendsService.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import Foundation
import Alamofire

protocol FriendsService {
    
    @discardableResult func getFriends(_ completion: @escaping (_ friends: [FriendModel]?, _ error: BaseServiceError?) -> Void) -> Request?
    
}
