//
//  SignInViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.08.2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loginTitleLabel: UILabel!
    @IBOutlet weak var loginTextField: TextField!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signInButton: PrimaryButton!
    @IBOutlet weak var signUpButton: SecondaryButton!
    
    // MARK: Private properties
    
    let loginConstant = "ANevmer"
    let passwordConstant = "Admin"
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        setupText()
    }
    
    // MARK: Actions
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        checkLogin()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        print("register")
    }
    
    // MARK: Private methods
    
    private func initializeSetup() {
        passwordTextField.isSecureTextEntry = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func checkLogin() {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           login == loginConstant,
           password == passwordConstant {
            
            print ("SUCCESS")
        }
        else {
            loginTextField.setErrorStyle()
            passwordTextField.setErrorStyle()
            let alertController = UIAlertController(title: "Информация", message: "Не верный логин или пароль", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: Extension for UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? TextField {
            textField.setNormalStyle()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case loginTextField:
            if let login = loginTextField.text, login != loginConstant {
                loginTextField.setErrorStyle()
            }
        case passwordTextField:
            if let password = loginTextField.text, password != passwordConstant {
                passwordTextField.setErrorStyle()
            }
        default:
            break
        }
    }
}

// MARK: Extension for localize

private extension SignInViewController {
    func setupText() {
        loginTitleLabel.text = "Логин или почта"
        passwordTitleLabel.text = "Пароль"
        signInButton.setTitle("Войти", for: .normal)
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
    }
}

