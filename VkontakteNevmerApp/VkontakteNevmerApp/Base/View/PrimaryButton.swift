//
//  PrimaryButton.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.08.2021.
//

import UIKit

class PrimaryButton: UIButton {

    // MARK: Lifecycle
            
    override func awakeFromNib() {
        super.awakeFromNib()
            
        applyStyle()
    }
    
    // MARK: Public methods
    
    func setShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.08
        layer.masksToBounds = false
    }
}

// MARK: Extension for styling

extension PrimaryButton {
        
    func applyStyle() {
        layer.cornerRadius = 12.0
        backgroundColor = .black
        setTitleColor(.white, for: .normal)
    }
}

// MARK: Extension for button states

extension PrimaryButton {
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .black : .black80
            super.isEnabled = isEnabled
        }
    }
}
