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
    
    let loginConstant = "Admin"
    let passwordConstant = "Admin"
    
    // MARK: Public properties
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeSetup()
        setupText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginTextField.text = ""
        passwordTextField.text = ""
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
        if let token = UserDefaults.standard.string(forKey: "AccessToken"), token == "token" {
            showMain()
        }
        navigationController?.navigationBar.isHidden = true
        passwordTextField.isSecureTextEntry = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func checkLogin() {
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           login == loginConstant,
           password == passwordConstant {
            showMain()
            UserDefaults.standard.set("token", forKey: "AccessToken")
            UserDefaults.standard.synchronize()
            
        }
        else {
            loginTextField.setErrorStyle()
            passwordTextField.setErrorStyle()
            let alertController = UIAlertController(title: "Информация", message: "Не верный логин или пароль", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    private func showMain() {
        let mainTC = UIStoryboard(name: "Navigation", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        self.navigationController?.pushViewController(mainTC, animated: true)
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

