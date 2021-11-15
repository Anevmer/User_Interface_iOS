//
//  FriendTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit
import Kingfisher

class FriendTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarContainreView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Public properties
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 2.0
    @IBInspectable var shadowOpacity: CGFloat = 0.4
    
    // MARK: Private properties
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }
    
    // MARK: Actions
    
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
    
    func configure(withModel model: FriendTableCellModel) {
        fullNameLabel.text = model.fullName
        if let avatarUrl = model.imageUrl,
           let url = URL(string: avatarUrl) {
            avatarImageView.kf.indicatorType = .activity
            avatarImageView.kf.setImage(with: url)
        }
        else {
            avatarImageView.image = UIImage(named: "userAvatarPlaceholderIcon")
        }
        
        if model.isOnline {
            setupOnlineIcon(isMobile: model.isMobile)
        }
        descriptionLabel.text = model.age
    }

    // MARK: Private methods
    
    func applyStyle() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
        avatarImageView.addGestureRecognizer(gestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
        
        selectionStyle = .none
        selectedBackgroundView?.backgroundColor = .clear
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarContainreView.layer.masksToBounds = false
        avatarContainreView.layer.cornerRadius = 24
        avatarContainreView.backgroundColor = .white
        avatarContainreView.layer.shadowColor = shadowColor.cgColor
        avatarContainreView.layer.shadowOffset = CGSize(width: 0, height: 3)
        avatarContainreView.layer.shadowRadius = shadowRadius
        avatarContainreView.layer.shadowOpacity = Float(shadowOpacity)

    }
    
    func setupOnlineIcon(isMobile: Bool) {
        let view = UIView()
        if isMobile {
            view.backgroundColor = .white
            view.frame = CGRect(x: avatarImageView.frame.maxX-10, y: avatarImageView.frame.maxY-10, width: 11, height: 16)
            view.layer.cornerRadius = 2
            let iconImageView = UIImageView(frame: CGRect(x: 0.5, y: 0.5, width: 10, height: 15))
            iconImageView.contentMode = .scaleAspectFill
            iconImageView.image = UIImage(named: "mobileOnlineIcon")
            view.addSubview(iconImageView)
            avatarContainreView.addSubview(view)
        }
        else {
            view.backgroundColor = .white
            view.frame = CGRect(x: avatarImageView.frame.maxX-12, y: avatarImageView.frame.maxY-12, width: 10, height: 10)
            view.layer.cornerRadius = 5
            let dotView = UIView(frame: CGRect(x: 2, y: 2, width: 6, height: 6))
            dotView.backgroundColor = .black
            dotView.layer.cornerRadius = 3
            view.addSubview(dotView)
            avatarContainreView.addSubview(view)
        }
    }
}
