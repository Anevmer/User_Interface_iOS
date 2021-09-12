//
//  ViewController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 26.08.2021.
//

import UIKit

extension UIViewController {
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        let blurView = UIView(frame: self.view.frame)
        blurView.backgroundColor = .init(white: 1.0, alpha: 0.8)
        activityIndicator.center = self.view.center
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        activityIndicator.tag = 100
        blurView.tag = 200
        
        view.addSubview(blurView)
        blurView.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let blurView = view.viewWithTag(200)
        blurView?.removeFromSuperview()
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}
