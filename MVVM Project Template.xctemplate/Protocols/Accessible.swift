//
//  Accessible.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum AccessibilityIdentifier: String {
    case example

    var description: String? {
        return nil
    }

    var hint: String? {
        return nil
    }
}

extension AccessibilityIdentifier {
    var id: String {
        return self.rawValue
    }
}

protocol Accessible {
    var accessibilityId: AccessibilityIdentifier { get }
}

extension Accessible where Self: UIAccessibilityElement {

    func setAccessibility(to identifier: AccessibilityIdentifier) {
        accessibilityIdentifier = identifier.id
        accessibilityLabel = identifier.description
        accessibilityHint = identifier.hint
    }

}
