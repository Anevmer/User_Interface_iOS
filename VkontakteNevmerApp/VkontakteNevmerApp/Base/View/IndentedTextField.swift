//
//  IndentedTextField.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import UIKit

@IBDesignable
class IndentedTextField: UITextField {

    // MARK: Public properties
    
    var padding = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

    @IBInspectable var left: CGFloat = 22.0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var right: CGFloat = 8.0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var top: CGFloat = 0.0 {
        didSet {
            adjustPadding()
        }
    }

    @IBInspectable var bottom: CGFloat = 0.0 {
        didSet {
            adjustPadding()
        }
    }
    
    // MARK: Lifecycle
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.size.width - 39, y: 0, width: 25, height: bounds.height)
    }
    
    // MARK: Private methods
    
    private func adjustPadding() {
        padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}
