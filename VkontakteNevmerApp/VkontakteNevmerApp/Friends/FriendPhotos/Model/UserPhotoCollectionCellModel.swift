//
//  UserPhotoCollectionCellModel.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import Foundation
import CollectionAndTableViewCompatible

class UserPhotoCollectionCellModel: Entity, CollectionViewCompatible {
    
    let photoName: String
    
    init (photoName: String) {
        self.photoName = photoName
    }
    
    // MARK: CollectionViewCompatible
    
    let reuseIdentifier: String = "UserPhotoCollectionViewCell"
    var selected: Bool = false
    var editable: Bool = false
    var movable: Bool = false
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserPhotoCollectionViewCell
        cell.configure(withEntity: self)
        
        return cell
    }
}
