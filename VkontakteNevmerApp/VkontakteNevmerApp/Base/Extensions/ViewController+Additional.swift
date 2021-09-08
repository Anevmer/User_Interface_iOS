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
    
    func showCustomActivityIndicator() {
        let stackView: UIStackView = {
            let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
            stackView.distribution = .fill
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.spacing = 10
            return stackView
        }()
        let blurView = UIView(frame: self.view.frame)
        blurView.backgroundColor = .init(white: 1.0, alpha: 0.8)
        
        stackView.center = blurView.center
        blurView.addSubview(stackView)
        self.view.addSubview(blurView)
        let dotOne = UIView()
        let dotTwo = UIView()
        let dotThree = UIView()
        let dots = [dotOne, dotTwo, dotThree]
        dots.forEach {
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.backgroundColor = .black
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
            stackView.addArrangedSubview($0)
        }

        let jumpDuration: Double = 0.30
        let delayDuration: Double = 1.25
        let totalDuration: Double = delayDuration + jumpDuration*2

        let jumpRelativeDuration: Double = jumpDuration / totalDuration
        let jumpRelativeTime: Double = delayDuration / totalDuration
        let fallRelativeTime: Double = (delayDuration + jumpDuration) / totalDuration
        
        for (index, circle) in dots.enumerated() {
            let delay = jumpDuration*2 * TimeInterval(index) / TimeInterval(dots.count)
            UIView.animateKeyframes(withDuration: totalDuration, delay: delay, options: [.repeat], animations: {
                UIView.addKeyframe(withRelativeStartTime: jumpRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y -= 30
                }
                UIView.addKeyframe(withRelativeStartTime: fallRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y += 30
                }
            })
        }
        
    }
}
