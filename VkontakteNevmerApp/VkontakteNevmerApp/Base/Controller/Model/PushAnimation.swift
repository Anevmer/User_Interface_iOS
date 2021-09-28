//
//  PushAnimation.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 20.09.2021.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        // Есть баг, не могу понять в чем причина
        // При ПЕРВОМ push экран source перемещается верхним правым углом к центру, а затем по анимации уезжает. Последующие push и pop работают без нареканий. Только при первом push
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        
        transitionContext.containerView.backgroundColor = .white
        transitionContext.containerView.addSubview(destination.view)
        
        let rotateTranslation = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 2))
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform  = rotateTranslation
        UIView.animateKeyframes(
            withDuration: animateTime,
            delay: 0.0,
            options: .calculationModePaced) {
            UIView.addKeyframe(
                withRelativeStartTime: 0,
                relativeDuration: 0.75) {
                let rotateTranslation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
                source.view.transform = rotateTranslation
            }
                
                UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                    let rotateTranslation = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))

                    source.view.transform = rotateTranslation
                }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
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
