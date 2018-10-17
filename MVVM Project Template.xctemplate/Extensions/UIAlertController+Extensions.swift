//
//  UIAlertController+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UIAlertAction {

    static var ok: UIAlertAction {
        return UIAlertAction(title: .localize(.ok), style: .default, handler: nil)
    }

    static var cancel: UIAlertAction {
        return UIAlertAction(title: .localize(.cancel), style: .cancel, handler: nil)
    }

    static func delete(handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: .localize(.delete), style: .destructive, handler: handler)
    }
}

extension UIAlertController {
    
    func removeTransparency() {
        view.subviews.last?.subviews.last?.backgroundColor = .white
        view.subviews.last?.subviews.last?.layer.cornerRadius = 16
    }
}
