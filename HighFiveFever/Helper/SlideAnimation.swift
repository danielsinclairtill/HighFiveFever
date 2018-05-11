//
//  SlideAnimation.swift
//  HighFiveFever
//
//  Created by Daniel Till on 5/12/18.
//  Copyright © 2018 Lunet Apps. All rights reserved.
//

import UIKit

class SlideAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var forward: Bool
    private let animationTime: TimeInterval = 0.5
    
    init(forward: Bool) {
        self.forward = forward
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        container.addSubview(toView)
        
        let xSlideValue = forward ? -fromView.frame.width : fromView.frame.width
        let fromViewToFrame = CGRect(x: xSlideValue, y: 0, width: toView.frame.width, height: toView.frame.height)
        
        toView.frame = CGRect(x: -xSlideValue, y: 0, width: toView.frame.width, height: toView.frame.height)
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: animationTime, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            toView.frame = fromView.frame
            fromView.frame = fromViewToFrame
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationTime
    }
}
