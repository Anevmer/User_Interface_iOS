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
    
    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        printDescription()
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
        showCustomActivityIndicator()
    }
    
    // MARK: Private methods
    
    private func initializeSetup() {
        if let userIdStr = UserDefaults.standard.string(forKey: "AccessToken"), let userId = Int(userIdStr) {
            currentUserId = userId
            showMain()
        }
        navigationController?.navigationBar.isHidden = true
        passwordTextField.isSecureTextEntry = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func checkLogin() {
        showActivityIndicator()
        if let login = loginTextField.text,
           let password = passwordTextField.text,
           login != "",
           password != "" {
            if let userId = loginUser(withLogin: login, andPass: password) {
                UserDefaults.standard.set("\(userId)", forKey: "AccessToken")
                UserDefaults.standard.synchronize()
                currentUserId = userId
                hideActivityIndicator()
                showMain()
            }
            else {
                setErrorStyle()
            }
        }
        else {
            setErrorStyle()
        }
    }
    
    private func setErrorStyle() {
        hideActivityIndicator()
        loginTextField.setErrorStyle()
        passwordTextField.setErrorStyle()
        let alertController = UIAlertController(title: "Информация", message: "Не верный логин или пароль", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func printDescription() {
        print ("""
            Возможные логины и пароли:
            admin - admin
            admin1 - admin1
            ... - ...
            admin9 - admin9
            """)
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
            if let login = loginTextField.text, login == "" {
                loginTextField.setErrorStyle()
            }
        case passwordTextField:
            if let password = loginTextField.text, password == "" {
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

