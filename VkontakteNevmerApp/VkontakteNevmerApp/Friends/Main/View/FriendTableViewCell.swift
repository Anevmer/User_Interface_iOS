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
    @IBOutlet weak var avatarContainreView: UIView!
    
    // MARK: Public properties
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 6.0
    @IBInspectable var shadowOpacity: CGFloat = 0.1
    
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

        // Реализация тени и закруглений без ShadowBackgroundView
        avatarContainreView.layer.masksToBounds = false
        avatarContainreView.layer.cornerRadius = 24
        avatarContainreView.backgroundColor = .white
        avatarContainreView.layer.shadowColor = shadowColor.cgColor
        avatarContainreView.layer.shadowOffset = CGSize(width: 0, height: 3)
        avatarContainreView.layer.shadowRadius = shadowRadius
        avatarContainreView.layer.shadowOpacity = Float(shadowOpacity)

    }
}
