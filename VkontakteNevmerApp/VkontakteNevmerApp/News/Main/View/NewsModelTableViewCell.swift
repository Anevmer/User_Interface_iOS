//
//  NewsModelTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import UIKit

class NewsModelTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    // MARK: Public properties
    
    // MARK: Private properties
    
    private var likesCount: Int = 0 {
        didSet {
            likeButton.setTitle("\(likesCount)", for: [])
        }
    }
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }

    // MARK: Public methods
    
    func configure(entity: Entity) {
        guard let model = entity as? NewsTableCellModel else { return }
        authorAvatarImageView.image = UIImage(named: model.avatarImageName)
        authorNameLabel.text = model.authorName
        createDateLabel.text = model.createDateString
        titleLabel.text = model.title
        contentImageView.isHidden = true
        likesCount = model.likesCount
        commentButton.setTitle("\(model.commentsCount)", for: [])
        
    }
    
    // MARK: Actions
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likesCount += 1
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: Private methods
    
    func applyStyle() {
        authorAvatarImageView.layer.cornerRadius = authorAvatarImageView.bounds.height / 2
        likeButton.layer.cornerRadius = likeButton.bounds.height / 2
        commentButton.layer.cornerRadius = commentButton.bounds.height / 2
    }
}
