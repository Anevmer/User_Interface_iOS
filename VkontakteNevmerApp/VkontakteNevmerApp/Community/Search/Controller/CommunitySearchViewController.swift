//
//  CommunitySearchViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class CommunitySearchViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private properties
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        applyStyle()
        setupText()
        loadData()
        
    }
    
    // MARK: Actions
    
    // MARK: Private methods
    
    func initializeSetup() {
        
    }
}

// MARK: Extension for styling

private extension CommunitySearchViewController {
    func applyStyle() {
        
    }
}

// MARK: Extension for localize

private extension CommunitySearchViewController {
    func setupText() {
        title = "Поиск сообществ"
    }
}

// MARK: Extension for data loading

extension CommunitySearchViewController {
    func loadData() {
        
    }
}
