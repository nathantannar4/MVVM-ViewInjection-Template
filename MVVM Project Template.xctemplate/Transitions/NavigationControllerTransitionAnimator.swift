//
//  NavigationControllerTransitionAnimator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NavigationControllerTransitionAnimator: ControllerTransitionAnimator, INavigationControllerTransitionAnimator {

    // MARK: - Properties

    override var duration: TimeInterval {
        return TimeInterval(UINavigationController.hideShowBarDuration)
    }

    // MARK: - Initialization

    required init(operation: UINavigationController.Operation) {
        super.init(isPresenting: operation == .push)
    }

    required init(isPresenting: Bool) {
        super.init(isPresenting: isPresenting)
    }

    // MARK: - Transition

    override func prepareTransition(using transitionContext: UIViewControllerContextTransitioning) {

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
        let dismissingViewStartFrame = isPresenting ? centerFrame : leftFrame

        dismissingView.frame = dismissingViewStartFrame
        presentingView.frame = presentingViewStartFrame
        presentingView.layoutIfNeeded()
    }

    override func animateAlongside(transitionContext: UIViewControllerContextTransitioning) {

        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let width = fromView.frame.width
        let height = fromView.frame.height
        let centerFrame = CGRect(x: 0, y: toView.frame.origin.y, width: width, height: height)
        let leftFrame = CGRect(x: -width / 8, y: fromView.frame.origin.y, width: width, height: height)
        let rightFrame = CGRect(x: width, y: fromView.frame.origin.y, width: width, height: height)

        let presentingViewEndFrame = isPresenting ? centerFrame : rightFrame
        let dismissingViewEndFrame = isPresenting ? leftFrame   : centerFrame

        let presentingView = isPresenting ? toView   : fromView
        let dismissingView = isPresenting ? fromView : toView
        presentingView.frame = presentingViewEndFrame
        dismissingView.frame = dismissingViewEndFrame
    }
}
