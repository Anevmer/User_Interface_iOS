//
//  SettingsViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var logOutButton: UIButton!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"

    }
    
    // MARK: Actions
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Вы действительно хотите выйти из профиля?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            UserDefaults.standard.removeObject(forKey: "AccessToken")
            self.tabBarController?.navigationController?.popToRootViewController(animated: true)
        }))
        present(ac, animated: true, completion: nil)
    }

}
