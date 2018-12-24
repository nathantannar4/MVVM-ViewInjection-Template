//
//  Theme.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum Theme: Int {
    case light = 0
    case dark

    static var `default`: Theme {
        return .light
    }
}
