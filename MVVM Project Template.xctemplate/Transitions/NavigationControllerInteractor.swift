//
//  NavigationControllerInteractor.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NavigationControllerInteractor: UIPercentDrivenInteractiveTransition {

    public private(set) var isInteracting: Bool = false
    private var isAtLeastHalfway: Bool = false
    private weak var navigationController: UINavigationController!

    init?(for viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else {
            return nil
        }
        super.init()
        self.navigationController = navigationController
        addSwipeGesture(in: viewController.view)
    }

    private func addSwipeGesture(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }

    @objc private func handlePanGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        let progress = translation.x / navigationController.view.bounds.width

        switch gesture.state {
        case .possible:
            break
        case .began:
            isInteracting = true
            navigationController.popViewController(animated: true)
        case .changed:
            isAtLeastHalfway = progress > 0.5
            update(progress)
        case .cancelled, .failed:
            isInteracting = false
            cancel()
        case .ended:
            isInteracting = false
            if gesture.velocity(in: gesture.view).x > 300 {
                finish()
            } else {
                isAtLeastHalfway ? finish() : cancel()
            }
        }
    }
}
