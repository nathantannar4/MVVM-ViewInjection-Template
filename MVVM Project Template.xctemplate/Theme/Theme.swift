//
//  Theme.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit.UIColor

enum Theme: Int {
    case light = 0
    case dark

    static var `default`: Theme {
        return .light
    }
}

extension UIColor {
    func adjustedForTheme(_ theme: Theme) -> UIColor {
        return theme == .dark ? self.darkModeColor() : self
    }
}
