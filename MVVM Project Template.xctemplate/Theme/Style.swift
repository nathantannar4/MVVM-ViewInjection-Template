//
//  Style.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct Style<View: UIView> {
    
    let style: (View) -> Void
    
    init(style: @escaping (View) -> Void) {
        self.style = style
    }
    
    /// Applies self to the view.
    func apply(to view: View) {
        style(view)
    }
    
    /// Style that does nothing (keeps the default/native style).
    static var native: Style<View> {
        return Style { _ in }
    }
}

extension UIView {
    
    /// For example: `let nameLabel = UILabel(style: Stylesheet.Profile.name)`.
    convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }
    
    convenience init<V>(style: Style<V>, override: @escaping (V) -> Void) {
        self.init(frame: .zero)
        apply(style.modifying(override))
    }
    
    /// Applies the given style to self.
    func apply<V>(_ style: Style<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    
    /// Returns self with the style applied. For example: `let nameLabel = UILabel().styled(with: Stylesheet.Profile.name)`.
    func styled<V>(with style: Style<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

extension Style {
    
    /// Returns current style modified by the given closure.
    func modifying(_ other: @escaping (View) -> Void) -> Style {
        return Style {
            self.apply(to: $0)
            other($0)
        }
    }
}
