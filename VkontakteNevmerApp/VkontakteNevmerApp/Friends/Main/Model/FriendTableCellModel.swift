//
//  FriendTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation
import CollectionAndTableViewCompatible
 
class FriendTableCellModel: Entity, TableViewCompatible {
    
    let fullName: String
    let firstName: String
    let surname: String
    let imageUrl: String?
    let age: String
    let id: Int
    var isOnline: Bool
    var isMobile: Bool
    
    init (friend: FriendModel) {
        id = friend.id ?? -1
        let name = friend.firstName ?? ""
        let surname = friend.lastName ?? ""
        self.firstName = name
        self.surname = surname
        fullName = name + " \(surname)"
        imageUrl = friend.photoUrl
        isOnline = friend.online == 1 ? true : false
        isMobile = friend.mobileOnline == 1 ? true : false
        let dateFormatter = DateFormatter(withFormat: "dd.MM.yyyy", locale: "ru")
        if let birthDate = dateFormatter.date(from: friend.birthday ?? "") {
            age = (birthDate.age).formattedAge()
        }
        else {
            age = ""
        }
    }
    
    init (realmFriend: FriendRealmModel) {
        id = realmFriend.id 
        let name = realmFriend.firstName 
        let surname = realmFriend.lastName 
        self.firstName = name
        self.surname = surname
        fullName = name + " \(surname)"
        imageUrl = realmFriend.photoUrl
        isOnline = realmFriend.online == 1 ? true : false
        isMobile = realmFriend.mobileOnline == 1 ? true : false
        let dateFormatter = DateFormatter(withFormat: "dd.MM.yyyy", locale: "ru")
        if let birthDate = dateFormatter.date(from: realmFriend.birthday ) {
            age = (birthDate.age).formattedAge()
        }
        else {
            age = ""
        }
    }
    
    // MARK: TableViewCompatible
        
        let reuseIdentifier: String = "FriendTableViewCell"
        var selected: Bool = false
        var editable: Bool = false
        var movable: Bool = false
        
        func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FriendTableViewCell
            cell.configure(withModel: self)
            
            return cell
        }
}
