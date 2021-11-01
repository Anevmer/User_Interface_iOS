//
//  UserPhotoCollectionViewDataSource.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.10.2021.
//

import Foundation
import CollectionAndTableViewCompatible

class UserPhotoCollectionViewDataSource: CollectionViewDataSource {
    
    // MARK: Public properties
    
    var data: [CollectionViewCompatible] {
        didSet {
            prepareData()
            collectionView.reloadData()
        }
    }
    
    // MARK: Init
    
    init(data: [CollectionViewCompatible] = [], collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "UserPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserPhotoCollectionViewCell")
        self.data = data
        super.init(collectionView: collectionView)
        prepareData()
    }
    
    func prepareData() {
        let section = CollectionViewSection(sortOrder: 0, items: data)
        sections = [section]
    }
}

