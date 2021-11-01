//
//  FriendsServiceImpl.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 07.10.2021.
//

import Foundation
import Alamofire

class FriendsServiceImpl: FriendsService {
    
    func getFriends(_ completion: @escaping (_ friends: [FriendModel]?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken,
              let userId = UserManager.shared.userId else {
            return nil
        }
        
        let parameters: Parameters = [
            "user_id" : userId,
            "access_token": accessToken,
            "order" : "hints",
            "count" : 5000,
            "fields" : "domain,city,photo_50,online,bdate",
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetFriendsResponse>()
        return webClient.request(path: "/friends.get", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response?.items, nil)
            }
        }
    }
    
    func getAllPhotoFor(ownerId: Int, _ completion: @escaping (_ photos: [Photo]?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken else {
            return nil
        }
        
        let parameters: Parameters = [
            "owner_id" : ownerId,
            "access_token": accessToken,
            "extended" : 1,
            "photo_sizes": 0,
            "count" : 20,
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetAllPhotosResponse>()
        return webClient.request(path: "/photos.getAll", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response?.items, nil)
            }
        }
    }
}
