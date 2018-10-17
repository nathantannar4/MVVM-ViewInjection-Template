//
//  ControlElement.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ControlElement: UIControl {

    enum ElementState: CaseIterable {
        case normal, highlighted, disabled
    }

    private(set) var currentState: ElementState = .normal

    final func setState(_ newState: ElementState) {
        currentState = newState
        stateDidChange()
    }

    func stateDidChange() {

    }
}
