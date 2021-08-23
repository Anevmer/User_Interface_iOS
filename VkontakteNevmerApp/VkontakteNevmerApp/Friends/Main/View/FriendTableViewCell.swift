//
//  FriendTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: Public properties
    
    // MARK: Private properties
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    // MARK: Public methods
    
    func configure(withEntity entity: Entity) {
        if let model = entity as? FriendTableCellModel {
            fullNameLabel.text = model.fullName
            avatarImageView.image = UIImage(named: model.imageName ?? "userAvatarPlaceholderIcon")
        }
    }

    // MARK: Private methods
    
    func applyStyle() {
        selectionStyle = .none
        roundedBackgroundView.layer.cornerRadius = 12
        roundedBackgroundView.layer.shadowColor = UIColor.black.cgColor
        roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        roundedBackgroundView.layer.shadowRadius = 6
        roundedBackgroundView.layer.shadowOpacity = 0.06
    }
}
