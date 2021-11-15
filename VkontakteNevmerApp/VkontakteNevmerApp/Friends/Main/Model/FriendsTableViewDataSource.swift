//
//  FriendsTableViewDataSource.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import CollectionAndTableViewCompatible

class FriendsTableViewDataSource: TableViewDataSource {
    
    // MARK: Public properties
    
    var dataWithSections: [Int: [TableViewCompatible]]
    var sectionTitles: [String]
    var data: [TableViewCompatible] {
        didSet {
            prepareData()
            tableView.reloadData()
        }
    }
    
    // MARK: Init
    
    init(data: [TableViewCompatible] = [], tableView: UITableView) {
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
        self.data = data
        dataWithSections = [:]
        sectionTitles = []
        super.init(tableView: tableView)
        prepareData()
    }
    
    // MARK: Private properties
    
    private func sortingMyFriends() -> [Int: [TableViewCompatible]] {
        var characters: [String.Element] = []
        self.sectionTitles.removeAll()
        guard let friends = data as? [FriendTableCellModel] else { return [:] }
        
        for friend in friends {
            if let firstSurnameCharacter = friend.surname.first {
                if !characters.contains(firstSurnameCharacter) {
                    characters.append(firstSurnameCharacter)
                }
            }
        }
        
        characters.sort { $0 < $1 }
        
        var i = 0
        var groupedUsers: [Int: [TableViewCompatible]] = [:]
        while i < characters.count {
            let character = characters[i]
            var characterUsers: [TableViewCompatible] = []
            for friend in friends {
                if let userCharacter = friend.surname.first, userCharacter == character {
                    characterUsers.append(friend)
                }
            }
            groupedUsers[i] = characterUsers
            self.sectionTitles.append(String.init(character))
            i += 1
        }
        
        return groupedUsers
        
    }
    
    private func prepareData() {
        sections = []
        self.dataWithSections = sortingMyFriends()
        var counter = 0
        while counter < sectionTitles.count {
            let title = sectionTitles[counter]
            if let tableViewCompatible = dataWithSections[counter] {
                let section = TableViewSection(sortOrder: counter, items: tableViewCompatible, headerTitle: title)
                sections.append(section)
            }
            counter += 1
        }
    }
}
