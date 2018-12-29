//
//  TabBarController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, IThemeable {

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return selectedViewController?.preferredStatusBarStyle ?? .default
    }

    var transitionAnimatorType: TabBarControllerTransitionAnimator.Type? {
        didSet {
            delegate = transitionAnimatorType != nil ? self : nil
        }
    }

    // MARK: - Initialization

    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        setViewControllers(viewControllers, animated: false)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToThemeChanges()
    }

    func themeDidChange(_ theme: Theme) {
        
    }

    // MARK: - UITabBarControllerDelegate

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard viewController == tabBarController.selectedViewController else {
            return true
        }

        guard let navigationController = viewController as? UINavigationController else {
            return true
        }

        if navigationController.viewControllers.count > 1 {
            navigationController.popToRootViewController(animated: true)
        }

        return false
    }

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let animatorType = transitionAnimatorType else { return nil }
        let fromIndex = tabBarController.viewControllers?.firstIndex(of: fromVC) ?? 0
        let toIndex = tabBarController.viewControllers?.firstIndex(of: toVC) ?? 1
        return animatorType.init(direction: fromIndex < toIndex ? .right : .left)
    }
}
