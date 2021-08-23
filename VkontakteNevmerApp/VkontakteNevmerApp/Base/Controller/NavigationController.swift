//
//  NavigationController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [
                .font : UIFont(name: "EtelkaBol", size: 20) ?? UIFont.systemFont(ofSize: 20),
                .foregroundColor : UIColor.black
            ]
            navigationBar.tintColor = .black
            navigationBar.compactAppearance = appearance
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.backgroundColor = appearance.backgroundColor
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }

        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        viewControllers.last?.navigationItem.backBarButtonItem = backItem
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count - 3 >= 0 {
            let penultimateViewController = viewControllers[viewControllers.count - 3]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            penultimateViewController.navigationItem.backBarButtonItem = backItem
        }
        
        return super.popViewController(animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)
        
        if viewControllers.count - 2 >= 0 {
            let penultimateViewController = viewControllers[viewControllers.count - 2]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            penultimateViewController.navigationItem.backBarButtonItem = backItem
        }
    }
}
