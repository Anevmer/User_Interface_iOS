//
//  SecondaryButton.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.08.2021.
//

import UIKit

class SecondaryButton: UIButton {

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

extension SecondaryButton {
        
    func applyStyle() {
        layer.cornerRadius = 12.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
       
    }
}

// MARK: Extension for button states

extension SecondaryButton {
    
    override var isEnabled: Bool {
        didSet {
            setTitleColor(isEnabled ? .black : .black80, for: .normal)
            super.isEnabled = isEnabled
        }
    }
}
