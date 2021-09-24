//
//  NewsModelTableViewCell.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 08.09.2021.
//

import UIKit

protocol NewsModelTableViewCellDelegate: class {
    func newsModelTableViewCell(_ cell: NewsModelTableViewCell, isLiked: Bool)
}

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
    
    weak var delegate: NewsModelTableViewCellDelegate?
    
    // MARK: Private properties
    
    private var isLiked: Bool = false {
        didSet {
            setIsLikedStyle(isLiked: isLiked)
        }
    }
    
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
        isLiked = model.isLiked
    }
    
    // MARK: Actions
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        isLiked = !isLiked
        if isLiked {
            likesCount += 1
        }
        else {
            likesCount -= 1
        }
        delegate?.newsModelTableViewCell(self, isLiked: isLiked)
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: Private methods
    
    private func setIsLikedStyle(isLiked: Bool) {
        if isLiked {
            likeButton.backgroundColor = .likeRed20
            likeButton.setTitleColor(.likeRed, for: [])
            likeButton.tintColor = .likeRed
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: [])
        }
        else {
            likeButton.backgroundColor = .systemGray5
            likeButton.setTitleColor(.systemGray, for: [])
            likeButton.tintColor = .systemGray
            likeButton.setImage(UIImage(systemName: "heart"), for: [])
        }
    }
    
    private func applyStyle() {
        authorAvatarImageView.layer.cornerRadius = authorAvatarImageView.bounds.height / 2
        likeButton.layer.cornerRadius = likeButton.bounds.height / 2
        commentButton.layer.cornerRadius = commentButton.bounds.height / 2
    }
}
