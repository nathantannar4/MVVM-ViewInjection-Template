//
//  ControllerTransitionAnimator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ControllerTransitionAnimator: NSObject, IControllerTransitionAnimator {

    // MARK: - Properties

    var duration: TimeInterval {
        return 0.3
    }

    var options: UIView.AnimationOptions {
        return [.curveEaseInOut]
    }

    let isPresenting: Bool

    // MARK: - Initialization

    required init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }

    // MARK: - Transition

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        prepareTransition(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            self?.animateAlongside(transitionContext: transitionContext)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    func prepareTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        let container = transitionContext.containerView
        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        toView.frame = container.frame
        toView.layoutIfNeeded()

        if isPresenting {
            toView.transform = CGAffineTransform(translationX: 0, y: toView.bounds.height)
        }
    }

    func animateAlongside(transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let fromView = transitionContext.view(forKey: .from) else { return }

        if isPresenting {
            toView.transform = .identity
        } else {
            fromView.transform = CGAffineTransform(translationX: 0, y: fromView.bounds.height)
        }
    }

    final func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}

