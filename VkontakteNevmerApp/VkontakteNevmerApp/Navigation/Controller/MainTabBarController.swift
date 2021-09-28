//
//  MainTabBarController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Private properties
    
    private var popGesture: UIGestureRecognizer?

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        applyStyle()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.navigationController!.responds(to: Selector(("interactivePopGestureRecognizer"))) {
            self.popGesture = navigationController!.interactivePopGestureRecognizer
            self.navigationController!.view.removeGestureRecognizer(navigationController!.interactivePopGestureRecognizer!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.popGesture != nil {
            navigationController!.view.addGestureRecognizer(self.popGesture!)
        }
    }

    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: Extension for UITabBarController delegate

extension MainTabBarController: UITabBarControllerDelegate {
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewControllers?.firstIndex(of: viewController) == 2 {
//            let personalManagerVC = UIStoryboard(name: "PersonalManager", bundle: nil).instantiateViewController(withIdentifier: "PersonalManagerViewController")
//            personalManagerVC.modalPresentationStyle = .overFullScreen
//            personalManagerVC.modalTransitionStyle = .crossDissolve
//            present(personalManagerVC, animated: true, completion: nil)
//
//            return false
//        }
//
//        return true
//    }
}

// MARK: Extension for styling

extension MainTabBarController {
    
    func applyStyle() {
        navigationController?.navigationBar.isHidden = true
        tabBar.barTintColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.gray
        tabBar.tintColor = UIColor.black
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4.0
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOpacity = 0.6
        tabBar.shadowImage = UIImage()
        
    }
}

// MARK: Extension for styling

extension MainTabBarController {
    
    func loadData() {
//        CompanyProfileServiceImpl().profile() { [weak self] (profile, error) in
//            guard let self = self else { return }
//            if let profile = profile {
//                let storage = UserDefaultsStorage()
//                if let fullName = profile.managerFullName {
//                    storage.set(fullName, forKey: .managerFullName)
//                }
//                if let email = profile.managerEmail {
//                    storage.set(email, forKey: .managerEmail)
//                }
//                if let phone = profile.managerPhone {
//                    storage.set(phone, forKey: .managerPhone)
//                }
//            }
//        }
    }
}
