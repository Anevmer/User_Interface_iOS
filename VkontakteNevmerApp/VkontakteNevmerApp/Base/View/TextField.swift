//
//  TextField.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.08.2021.
//

import UIKit

class TextField: UITextField {
    
    // MARK: Lyfecycle
    
    override func awakeFromNib() {
        setNormalStyle()
        applyStyle()
    }
    
    // Placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }
    
    // Text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 14, dy: 0)
    }
    
    // MARK: Private methods
    
    func applyStyle() {
        layer.cornerRadius = 10
    }
    
    // MARK: Set customStyles
    
    func setNormalStyle() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setErrorStyle() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.red.cgColor
    }
}
