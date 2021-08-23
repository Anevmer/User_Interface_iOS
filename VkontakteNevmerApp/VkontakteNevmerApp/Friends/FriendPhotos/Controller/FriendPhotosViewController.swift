//
//  FriendPhotosViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class FriendPhotosViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Public properties
    
    var fullName: String?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupCollectionView()
    }
    
    // MARK: Private methods
    
    private func setupCollectionView() {
        
    }
}

// MARK: Extension for data loading

extension FriendPhotosViewController {
    func loadData() {
        if let fullName = fullName {
            title = fullName
        }
        else {
            title = "Фотоальбом"
        }
    }
}
