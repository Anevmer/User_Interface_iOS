//
//  LoadingView.swift
//  VkontakteNevmerApp
//
//  Created by Anatoly Nevmerzhitsky on 12.09.2021.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: Private properties
    
    private let stackView: UIStackView = {
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private let dotOne = UIView()
    private let dotTwo = UIView()
    private let dotThree = UIView()
    private lazy var dots = [dotOne, dotTwo, dotThree]
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        applyStyle()
    }
    
    // MARK: Public methods
    
    func animate() {
        self.alpha = 1
        let jumpDuration: Double = 0.30
        let delayDuration: Double = 1.0
        let totalDuration: Double = delayDuration + jumpDuration*2
        
        let jumpRelativeDuration: Double = jumpDuration / totalDuration
        let jumpRelativeTime: Double = delayDuration / totalDuration
        let fallRelativeTime: Double = (delayDuration + jumpDuration) / totalDuration
        
        for (index, dot) in dots.enumerated() {
            let delay = jumpDuration*2 * TimeInterval(index) / TimeInterval(dots.count)
            UIView.animateKeyframes(withDuration: totalDuration, delay: delay, options: [.repeat], animations: {
                UIView.addKeyframe(withRelativeStartTime: jumpRelativeTime, relativeDuration: jumpRelativeDuration) {
                    dot.frame.origin.y -= 30
                }
                UIView.addKeyframe(withRelativeStartTime: fallRelativeTime, relativeDuration: jumpRelativeDuration) {
                    dot.frame.origin.y += 30
                }
            })
        }
    }
    
    func stopAnimate() {
        for (dot) in dots {
            dot.layer.removeAllAnimations()
        }
        self.alpha = 0
    }
    
    // MARK: Private methods
    
    private func applyStyle() {
        self.alpha = 0
        self.backgroundColor = .white50
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dots.forEach {
            $0.layer.cornerRadius = 20/2
            $0.layer.masksToBounds = true
            $0.backgroundColor = .black
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    }
}
