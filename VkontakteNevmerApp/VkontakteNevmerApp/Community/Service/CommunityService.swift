//
//  CommunityService.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import Alamofire

protocol CommunityService {
    @discardableResult func getCommunities(_ completion: @escaping (_ communities: [CommunityModel]?, _ error: BaseServiceError?) -> Void) -> Request?
    @discardableResult func joinGroup(groupId: Int,  completion: @escaping(_ response: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request?
    @discardableResult func leaveGroup(groupId: Int,  completion: @escaping(_ response: BaseResponse?, _ error: BaseServiceError?) -> Void) -> Request?
    @discardableResult func searchCommunities(searchText: String, completion: @escaping (_ communities: [CommunityModel]?, _ error: BaseServiceError?) -> Void) -> Request?
}
