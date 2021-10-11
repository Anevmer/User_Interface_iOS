//
//  FriendsServiceImpl.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import Foundation
import Alamofire

class FriendsServiceImpl: FriendsService {
    
    func getFriends(_ completion: @escaping (_ friends: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken,
              let userId = UserManager.shared.userId else {
            return nil
        }
        
        let headers: HTTPHeaders = [
            "access_token" : accessToken
        ]
        
        let parameters: Parameters = [
            "user_id" : userId,
            "access_token": accessToken,
            "order" : "hints",
            "count" : 5000,
            "fields" : "domain,city",
            "v" : "5.131"
         ]
        
        let webClient = WebClient<BaseResponse>()
        return webClient.request(path: "/friends.get", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response, nil)
            }
        }
    }
}
