//
//  TextField.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.08.2021.
//

import UIKit
import SwiftValidator

class TextField: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: IndentedTextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: Public properties
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    var returnKeyType: UIReturnKeyType = .default {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    var placeholder: String? {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor : UIColor.gray, .font : UIFont.systemFont(ofSize: 15, weight: .medium)])
        }
    }
    
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    // MARK: Public methods
    
    func showErrorMessage(_ message: String?) {
        textField.layer.borderColor = UIColor.red.cgColor
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideErrorMessage() {
        textField.layer.borderColor = textField.isEditing ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
        errorLabel.text = " "
        errorLabel.isHidden = true
    }
    
    // MARK: Private methods
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        applyStyle()
    }
    
    private func applyStyle() {
        hideErrorMessage()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        titleLabel.textColor = .black
    }
}

// MARK: Extension for validation

extension TextField: Validatable {

    public var validationText: String {
        return textField.text ?? ""
    }
}
