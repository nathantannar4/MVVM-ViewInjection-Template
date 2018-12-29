//
//  ControllerTransitionAnimator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: TimeInterval {
        return 0.3
    }

    var options: UIView.AnimationOptions {
        return [.curveEaseInOut]
    }
    let isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        prepareTransition(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            self?.animateAlongside(transitionContext: transitionContext)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    func prepareTransition(using transitionContext: UIViewControllerContextTransitioning) {

    }

    func animateAlongside(transitionContext: UIViewControllerContextTransitioning) {

    }

    final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}

