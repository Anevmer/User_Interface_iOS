//
//  RealmService.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 01.11.2021.
//

import Foundation
import RealmSwift

final class RealmService {
    static let deleteMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T:Object> (
        items: [T],
        confuguration: Realm.Configuration = deleteMigration,
        update: Realm.UpdatePolicy = .modified) throws {
            let realm = try Realm(configuration: confuguration)
            print (confuguration.fileURL ?? "")
            try realm.write {
                realm.add(items, update: update)
            }
        }
    
    static func load<T: Object>(typeOf: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(T.self)
    }
    
    static func delete<T: Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}
