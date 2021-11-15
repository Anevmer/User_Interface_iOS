//
//  FriendRealmModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 01.11.2021.
//

import Foundation
import RealmSwift

class FriendRealmModel: Object {
    
    @objc dynamic var realmId: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var domain: String = ""
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var mobileOnline: Int = 0
    @objc dynamic var birthday: String = ""
    
    override class func primaryKey() -> String? {
        "realmId"
    }

    convenience init(friendModel: FriendModel) {
        self.init()
        self.firstName = friendModel.firstName ?? ""
        self.lastName = friendModel.lastName ?? ""
        self.id = friendModel.id ?? -1
        self.realmId = "user_\(id)"
        self.domain = friendModel.domain ?? ""
        self.photoUrl = friendModel.photoUrl ?? ""
        self.online = friendModel.online ?? 0
        self.mobileOnline = friendModel.mobileOnline ?? 0
        self.birthday = friendModel.birthday ?? ""
        
    }
}
