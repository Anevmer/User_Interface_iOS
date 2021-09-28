//
//  NavigationController.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 23.08.2021.
//

import UIKit

// --

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var isStarted = false
    var shouldFinish = false
}

// --

class NavigationController: UINavigationController {
    
    // --
    
    private let pushAnimatior = PushAnimation()
    private let popAnimator = PopAnimation()
    private let interactiveTransition = CustomInteractiveTransition()
    
    // --
    
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
            
            // --            
//            delegate = self
//            let edgePanGR = UIScreenEdgePanGestureRecognizer(
//                target: self,
//                action: #selector(handlePan(_:)))
//            edgePanGR.edges = .left
//            view.addGestureRecognizer(edgePanGR)
            // --
        }
    }
    
    // --
    
//    @objc
//    private func handlePan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            interactiveTransition.isStarted = true
//            popViewController(animated: true)
//
//        case .changed:
//            guard let width = recognizer.view?.bounds.width else {
//                interactiveTransition.isStarted = false
//                interactiveTransition.cancel()
//                return
//            }
//
//            let translation = recognizer.translation(in: view)
//            let relativeTranslation = translation.x / width
//            let progress = max(0, min(relativeTranslation, 1))
//            print(translation, relativeTranslation , progress)
//            interactiveTransition.update(progress)
//            interactiveTransition.shouldFinish = progress > 0.35
//
//        case .ended:
//            interactiveTransition.isStarted = false
//            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()
//
//        case
//            .failed,
//            .cancelled:
//            interactiveTransition.isStarted = false
//            interactiveTransition.cancel()
//
//        default: break
//        }
//    }
//
    // --
    
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

// --
//
//extension NavigationController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController,
//        animationControllerFor operation: UINavigationController.Operation,
//        from fromVC: UIViewController,
//        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        switch operation {
//        case .push:
//            return pushAnimatior
//        case .pop:
//            return popAnimator
//        default:
//            return nil
//        }
//    }
//
//    func navigationController(
//        _ navigationController: UINavigationController,
//        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        interactiveTransition.isStarted ? interactiveTransition : nil
//    }
//}
//
// --
