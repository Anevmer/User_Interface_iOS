//
//  CommunityRealmModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 01.11.2021.
//

import Foundation
import RealmSwift

class CommunityRealmModel: Object {
    @objc dynamic var realmId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var verified: Int = 0
    
    override class func primaryKey() -> String? {
        "realmId"
    }
    
    convenience init(communityModel: CommunityModel) {
        self.init()
        self.name = communityModel.name ?? ""
        self.screenName = communityModel.screenName ?? ""
        self.id = communityModel.id ?? -1
        self.realmId = "group_\(id)"
        self.photoUrl = communityModel.photoUrl ?? ""
        self.status = communityModel.status ?? ""
        self.verified = communityModel.verified ?? -1
    }
}
