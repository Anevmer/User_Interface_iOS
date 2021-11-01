//
//  CommunitiesTableViewDataSource.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 11.10.2021.
//

import Foundation
import CollectionAndTableViewCompatible

class CommunitiesTableViewDataSource: TableViewDataSource {
    
    // MARK: Public properties
    
    var data: [TableViewCompatible] {
        didSet {
            prepareData()
            tableView.reloadData()
        }
    }
    
    // MARK: Init
    
    init(data: [TableViewCompatible] = [], tableView: UITableView) {
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "CommunityTableViewCell")
        self.data = data
        super.init(tableView: tableView)
        prepareData()
    }
    
    func prepareData() {
        let section = TableViewSection(sortOrder: 0, items: data)
        sections = [section]
    }
}
