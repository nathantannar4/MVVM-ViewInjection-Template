//
//  NSLayoutConstraint+Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on 3/11/18.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    func withPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    @discardableResult
    func activated() -> NSLayoutConstraint {
        NSLayoutConstraint.activate([self])
        return self
    }
}
