//
//  ValidationManager.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 28.09.2021.
//

import UIKit
import SwiftValidator
import IQKeyboardManagerSwift
import InputMask

protocol ValidationManagerDelegate: class {
    
    func validationManager(_ validationManager: ValidationManager, textFieldDidBeginEditing textField: UITextField)
    func validationManager(_ validationManager: ValidationManager, textFieldEditingChanged textField: UITextField)
    func validationManager(_ validationManager: ValidationManager, textFieldDidEndEditing textField: UITextField)
    func validationManager(_ validationManager: ValidationManager, textViewDidBeginEditing textView: UITextView)
    func validationManager(_ validationManager: ValidationManager, textViewEditingChanged textView: UITextView)
    func validationManager(_ validationManager: ValidationManager, textViewDidEndEditing textView: UITextView)
    func validationManagerDidValidateSuccessfully(_ validationManager: ValidationManager)
}

extension ValidationManagerDelegate {
    
    func validationManager(_ validationManager: ValidationManager, textFieldDidBeginEditing textField: UITextField) { }
    func validationManager(_ validationManager: ValidationManager, textFieldEditingChanged textField: UITextField) { }
    func validationManager(_ validationManager: ValidationManager, textFieldDidEndEditing textField: UITextField) { }
    func validationManager(_ validationManager: ValidationManager, textViewDidBeginEditing textView: UITextView) { }
    func validationManager(_ validationManager: ValidationManager, textViewEditingChanged textView: UITextView) { }
    func validationManager(_ validationManager: ValidationManager, textViewDidEndEditing textView: UITextView) { }
}

class ValidationManager: NSObject {

    // MARK: Public properties
    
    let validator: Validator
    let fields: [Validatable]
    weak var delegate: ValidationManagerDelegate?
    
    // MARK: Init
    
    init(validator: Validator, fields: [Validatable]) {
        self.validator = validator
        self.fields = fields
        super.init()
        
        registerValidationRules()
        for field in fields {
            if let textField = field as? TextField {
                textField.textField.delegate = self
                textField.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            }
            
        }
    }
    
    // MARK: Public methods
    
    func registerValidationRules() {
        
    }
    
    func updateValidationRules() {
        for field in fields {
            unregisterField(field)
        }
    }
    
    func registerField(_ field: Validatable, withRules rules: [Rule]) {
        if let textField = field as? TextField {
            textField.textField.delegate = self
            textField.textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
            validator.registerField(textField.textField, errorLabel: textField.errorLabel, rules: rules)
        }
    }
    
    func unregisterField(_ field: Validatable) {
        if let textField = field as? TextField {
            validator.unregisterField(textField.textField)
        }
    }
    
    func updateField(_ field: Validatable, rules: [Rule]) {
        unregisterField(field)
        registerField(field, withRules: rules)
    }
    
    func isFieldRegistered(_ field: Validatable) -> Bool {
        if let textField = field as? TextField {
            return validator.validations[textField.textField] != nil
        }
        
        return false
    }
    
    func validate() {
        validator.validate(self)
    }
    
    func validateTextField(_ field: Validatable) {
        if let textField = field as? TextField {
            validator.validateField(textField.textField) { error in
                if let error = error {
                    textField.showErrorMessage(error.errorMessage)
                }
                else {
                    textField.hideErrorMessage()
                }
            }
        }
    }
    
    func hideErrors() {
        for field in fields {
            if let textField = field as? TextField {
                textField.hideErrorMessage()
            }
        }
    }
    
    // MARK: Actions
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if let textField = fields.first(where: { $0 is TextField && ($0 as! TextField).textField == textField }) {
            validateTextField(textField)
        }
        delegate?.validationManager(self, textFieldEditingChanged: textField)
    }
}

// MARK: Extension for UITextField delegate

extension ValidationManager: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.validationManager(self, textFieldDidBeginEditing: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            IQKeyboardManager.shared.goNext()
        }
        else if textField.returnKeyType == .done {
            textField.resignFirstResponder()
            validate()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = fields.first(where: { $0 is TextField && ($0 as! TextField).textField == textField }) {
            validateTextField(textField)
        }
        delegate?.validationManager(self, textFieldDidEndEditing: textField)
    }
}

// MARK: Extension for Validation delegate

extension ValidationManager: ValidationDelegate {
    
    func validationSuccessful() {
        delegate?.validationManagerDidValidateSuccessfully(self)
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        for (field, error) in errors {
            if let textField = field as? UITextField,
                let textFieldView = fields.first(where: { $0 is TextField && ($0 as! TextField).textField == textField }) as? TextField {
                textFieldView.showErrorMessage(error.errorMessage)
            }
        }
    }
}

