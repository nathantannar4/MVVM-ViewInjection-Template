//
//  NavigationControllerTransitionAnimator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NavigationControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: TimeInterval {
        return TimeInterval(UINavigationController.hideShowBarDuration)
    }
    var options: UIView.AnimationOptions {
        return [.allowUserInteraction, .beginFromCurrentState, .curveLinear]
    }
    let isPresenting: Bool

    required init(operation: UINavigationController.Operation) {
        self.isPresenting = operation == .push
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView

        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let width = fromView.frame.width
        let height = fromView.frame.height
        let centerFrame = CGRect(x: 0, y: toView.frame.origin.y, width: width, height: height)
        let leftFrame = CGRect(x: -width / 8, y: fromView.frame.origin.y, width: width, height: height)
        let rightFrame = CGRect(x: width, y: fromView.frame.origin.y, width: width, height: height)

        isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)

        let presentingView = isPresenting ? toView   : fromView
        let dismissingView = isPresenting ? fromView : toView
        let presentingViewStartFrame = isPresenting ? rightFrame  : centerFrame
        let presentingViewEndFrame   = isPresenting ? centerFrame : rightFrame
        let dismissingViewStartFrame = isPresenting ? centerFrame : leftFrame
        let dismissingViewEndFrame   = isPresenting ? leftFrame   : centerFrame
        dismissingView.frame = dismissingViewStartFrame
        presentingView.frame = presentingViewStartFrame
        presentingView.layer.addShadow()
        presentingView.layoutIfNeeded()

        UIView.animate(withDuration: duration, delay: 0, options: options, animations: { [weak self] in
            presentingView.frame = presentingViewEndFrame
            dismissingView.frame = dismissingViewEndFrame
            self?.animateAlongside(context: transitionContext)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    func animateAlongside(context: UIViewControllerContextTransitioning) {

    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

}
