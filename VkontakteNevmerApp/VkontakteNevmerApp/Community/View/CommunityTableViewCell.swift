//
//  CommunityTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

protocol CommunityTableViewCellDelegate: class {
    func communityTableViewCellMoreButton(_ cell: CommunityTableViewCell)
}

class CommunityTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
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
        avataImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(
            withDuration: 1.6,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.2,
            options: .curveEaseOut,
            animations: {
                self.avataImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            },
            completion: nil)
    }

    // MARK: Public methods
    
    func configure(withEntity entity: Entity) {
        if let model = entity as? CommunityTableCellModel {
            delegate = model.delegate
            fullNameLabel.text = model.fullName
            avataImageView.image = UIImage(named: model.avatarName)
            
        }
    }

    // MARK: Private methods
    
    func applyStyle() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
        avataImageView.addGestureRecognizer(gestureRecognizer)
        avataImageView.isUserInteractionEnabled = true
        
        selectionStyle = .none
        roundedBackgroundView.layer.cornerRadius = 12
        roundedBackgroundView.layer.shadowColor = UIColor.black.cgColor
        roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        roundedBackgroundView.layer.shadowRadius = 6
        roundedBackgroundView.layer.shadowOpacity = 0.06
    }
}
