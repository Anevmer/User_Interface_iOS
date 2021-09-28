//
//  PopAnimation.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 20.09.2021.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        transitionContext.containerView.insertSubview(
            destination.view,
            belowSubview: source.view)
        
        let rotateTranslation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = rotateTranslation
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.4) {
                let rotateTranslation = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 2))
                source.view.transform = rotateTranslation
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: 0.4,
                relativeDuration: 0.4) {
                source.view.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 2))
            }
                
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                destination.view.transform = .identity
            }
        } completion: { isCompleted in
            if isCompleted && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            
            transitionContext.completeTransition(isCompleted && !transitionContext.transitionWasCancelled)
        }
    }
}
