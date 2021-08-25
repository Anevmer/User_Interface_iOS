//
//  CommunityTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var avataImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    // MARK: Public properties
    
    // MARK: Private properties
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    // MARK: Public methods
    
    func configure(withEntity entity: Entity) {
        if let model = entity as? CommunityTableCellModel {
            fullNameLabel.text = model.fullName
            avataImageView.image = UIImage(named: model.avatarName)
            
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
