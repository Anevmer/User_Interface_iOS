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
    let imageName: String?
    let imageUrl: String?
    let age: String
    let user: UserProfile?
    var isOnline: Bool
    var isMobile: Bool
    
    init (user: UserProfile) {
        self.user = user
        self.fullName = user.name + " " + user.surname
        self.imageName = user.avatarName == "" ? nil : user.avatarName
        self.imageUrl = nil
        self.firstName = user.name
        self.surname = user.surname
        isOnline = false
        isMobile = false
        age = ""
    }
    
    init (friend: FriendModel) {
        let name = friend.firstName ?? ""
        let surname = friend.lastName ?? ""
        self.firstName = name
        self.surname = surname
        fullName = name + " \(surname)"
        imageUrl = friend.photoUrl
        user = nil
        imageName = nil
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
