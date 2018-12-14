//
//  Appearance.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift

enum Theme {
    case light
    case dark

    static var `default`: Theme {
        return .light
    }
}

var CurrentTheme: Theme {
    return Appearance.shared.theme.value ?? .default
}

class Appearance {
    static var shared = Appearance()
    fileprivate let theme = BehaviorSubject<Theme>(value: .default)

    func setCurrentTheme(_ theme: Theme, animated: Bool) {
        UIView.animate(
            withDuration: animated ? 0.5 : 0.0,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [.transitionCrossDissolve],
            animations: { [weak self] in
                self?.theme.onNext(theme)
        })
    }
}

private struct AssociatedKeys {
    static var ThemeDisposeBag = "ThemeDisposeBag"
}

protocol UIResponderThemable: AnyObject {
    func themeDidChange(_ theme: Theme)
}

extension UIResponderThemable where Self: UIResponder {
    func registerForThemeChanges() {
        Appearance.shared.theme.subscribe { [weak self] event in
            switch event {
            case .next(let theme):
                self?.themeDidChange(theme)
            case .error, .completed:
                break
            }
        }.disposed(by: themeDisposeBag)
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
