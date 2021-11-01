//
//  CommunityTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit
import Kingfisher

protocol CommunityTableViewCellDelegate: class {
    func communityTableViewCellMoreButton(_ cell: CommunityTableViewCell)
}

class CommunityTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    // MARK: Public properties
    
    weak var delegate: CommunityTableViewCellDelegate?
        
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }
    
    // MARK: Actions
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
        delegate?.communityTableViewCellMoreButton(self)
    }
    
    @objc private func tapImageView() {
        avatarImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(
            withDuration: 1.6,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.2,
            options: .curveEaseOut,
            animations: {
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            },
            completion: nil)
    }

    // MARK: Public methods
    
    func configure(withEntity entity: Entity) {
        if let model = entity as? CommunityTableCellModel {
            delegate = model.delegate
            fullNameLabel.text = model.fullName
            avatarImageView.image = UIImage(named: model.avatarName)
            statusLabel.text = model.status
            checkImageView.isHidden = !model.isVerified
            if let url = URL(string: model.avatarName) {
                avatarImageView.kf.indicatorType = .activity
                avatarImageView.kf.setImage(with: url)
            }
            else if model.avatarName != "" {
                avatarImageView.image = UIImage(named: model.avatarName )
            }
            else {
                avatarImageView.image = UIImage(named: "userAvatarPlaceholderIcon")
            }
        }
    }

    // MARK: Private methods
    
    func applyStyle() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
        avatarImageView.addGestureRecognizer(gestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        
        selectionStyle = .none
        roundedBackgroundView.layer.cornerRadius = 12
        roundedBackgroundView.layer.shadowColor = UIColor.black.cgColor
        roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        roundedBackgroundView.layer.shadowRadius = 6
        roundedBackgroundView.layer.shadowOpacity = 0.06
    }
}
