//
//  CommunityServiceImpl.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import Alamofire
import RealmSwift

class CommunityServiceImpl: CommunityService {
    
    private func saveToRealm(_ object: [Object]) {
        do {
            try RealmService.save(items: object)
        } catch {
            print (error)
        }
    }
    
//    private func deleteFromRealm(_ object: Object) {
//        do {
//            try RealmService.delete(object: CommunityRealmModel.Type)
//        } catch {
//            print (error)
//        }
//    }
    
    func getCommunities(_ completion: @escaping (_ communities: [CommunityModel]?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken,
              let userId = UserManager.shared.userId else {
            return nil
        }
        
        let parameters: Parameters = [
            "user_id" : userId,
            "access_token": accessToken,
            "count" : 1000,
            "extended" : 1,
            "fields" : "city,members_count,status,verified",
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetCommunitiesResponse>()
        return webClient.request(path: "/groups.get", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                if let communities = response?.items {
                    let realmCommunities = communities.map({CommunityRealmModel(communityModel: $0)})
                    self.saveToRealm(realmCommunities)
                    completion(communities, nil)
                }
            }
        }
    }
    
    func searchCommunities(searchText: String, completion: @escaping (_ communities: [CommunityModel]?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken else {
            return nil
        }
        
        let parameters: Parameters = [
            "q" : searchText,
            "access_token" : accessToken,
            "count" : 100,
            "sort" : 6,
            "fields" : "city,members_count,status,verified",
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetCommunitiesResponse>()
        return webClient.request(path: "/groups.search", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response?.items, nil)
            }
        }
    }
    
    func joinGroup(groupId: Int,  completion: @escaping(_ response: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken else {
            return nil
        }
        
        let parameters: Parameters = [
            "group_id" : groupId,
            "access_token": accessToken,
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetCommunitiesResponse>()
        return webClient.request(path: "/groups.join", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response, nil)
            }
        }
    }
    
    func leaveGroup(groupId: Int,  completion: @escaping(_ response: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request? {
        guard let accessToken = UserManager.shared.accessToken else {
            return nil
        }
        
        let parameters: Parameters = [
            "group_id" : groupId,
            "access_token": accessToken,
            "v" : "5.131"
         ]
        
        let webClient = WebClient<GetCommunitiesResponse>()
        return webClient.request(path: "/groups.leave", parameters: parameters) { (response, error) in
            if let error = error {
                completion(nil, error)
            }
            else {
                completion(response, nil)
            }
        }
    }
}


