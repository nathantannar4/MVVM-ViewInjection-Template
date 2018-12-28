//
//  Appearance.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift

final class ThemeManager {
    static let shared = ThemeManager()

    fileprivate let currentTheme = BehaviorSubject<Theme>(value: .default)

    private init() { }

    func getCurrentTheme() -> Theme {
        return currentTheme.value ?? .default
    }

    func setCurrentTheme(_ theme: Theme, animated: Bool) {
        guard animated else {
            currentTheme.onNext(theme)
            return
        }
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.transitionCrossDissolve],
            animations: { [weak self] in
                self?.currentTheme.onNext(theme)
        })
    }
}

private struct AssociatedKeys {
    static var ThemeDisposeBag = "ThemeDisposeBag"
}

extension IThemeable where Self: UIResponder {
    func subscribeToThemeChanges() {
        ThemeManager.shared.currentTheme.subscribe(onNext: { [weak self] theme in
            self?.themeDidChange(theme)
        }).disposed(by: themeDisposeBag)

        if let theme = ThemeManager.shared.currentTheme.value {
            themeDidChange(theme)
        }
    }

    private var themeDisposeBag: DisposeBag {
        get {
            guard let disposeBag = objc_getAssociatedObject(self, &AssociatedKeys.ThemeDisposeBag) as? DisposeBag else {
                let newBag = DisposeBag()
                self.themeDisposeBag = newBag
                return newBag
            }
            return disposeBag
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ThemeDisposeBag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
