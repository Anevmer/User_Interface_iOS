//
//  UserPhotoCollectionViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 24.08.2021.
//

import UIKit

class UserPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 4
    }
    
    // MARK: Public methods
    
    func configure(withEntity entity: Entity) {
        let model = entity as! UserPhotoCollectionCellModel
        
        imageView.image = UIImage(named: model.photoName)
    }
}
