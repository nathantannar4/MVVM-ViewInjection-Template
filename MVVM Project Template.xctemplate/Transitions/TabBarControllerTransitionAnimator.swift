//
//  TabBarControllerTransitionAnimator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TabBarControllerTransitionAnimator: ControllerTransitionAnimator {
    enum Direction {
        case left, right
    }

    override var duration: TimeInterval {
        return 0.3
    }

    var bounceOffset: CGFloat {
        return 30
    }

    let direction: Direction

    required init(direction: Direction) {
        self.direction = direction
        super.init(isPresenting: true)
    }

    override func prepareTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let contentView = transitionContext.contentView(forKey: .to) else { return }

        let container = transitionContext.containerView
        container.addSubview(toView)

        var frame = contentView.frame
        frame.origin.x = direction == .right ? bounceOffset : -bounceOffset
        contentView.frame = frame
        contentView.layoutIfNeeded()
        toView.alpha = 0
    }

    override func animateAlongside(transitionContext: UIViewControllerContextTransitioning) {

        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard let contentView = transitionContext.contentView(forKey: .to) else { return }

        contentView.frame = CGRect(origin: CGPoint(x: 0, y: contentView.frame.origin.y), size: contentView.frame.size)
        toView.alpha = 1
    }
}

private extension UIViewControllerContextTransitioning {

    func contentView(forKey key: UITransitionContextViewControllerKey) -> UIView? {

        let vc = viewController(forKey: key)
        return ((vc as? UINavigationController)?.visibleViewController ?? vc)?.view
    }
}
