//
//  CommunityTableCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import Foundation
import CollectionAndTableViewCompatible

class CommunityTableCellModel: Entity, TableViewCompatible {
    
    let fullName: String
    let avatarName: String
    let delegate: CommunityTableViewCellDelegate
    let id: Int
    let isVerified: Bool
    let status: String
    
    init(community: Community, delegate: CommunityTableViewCellDelegate) {
        self.delegate = delegate
        id = community.id
        fullName = community.name
        avatarName = community.avatarName
        isVerified = false
        status = ""
    }
    
    init(_ communityModel: CommunityModel, delegate: CommunityTableViewCellDelegate) {
        self.delegate = delegate
        id = communityModel.id ?? -1
        fullName = communityModel.name ?? ""
        isVerified = communityModel.verified == 1 ? true : false
        avatarName = communityModel.photoUrl ?? ""
        status = communityModel.status ?? ""
    }
    
    // MARK: TableViewCompatible
       
       let reuseIdentifier: String = "CommunityTableViewCell"
       var selected: Bool = false
       var editable: Bool = false
       var movable: Bool = false
       
       func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CommunityTableViewCell
        cell.configure(withEntity: self)
           
           return cell
       }
}
