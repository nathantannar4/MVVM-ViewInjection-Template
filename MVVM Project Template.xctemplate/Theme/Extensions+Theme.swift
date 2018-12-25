//
//  Extensions+Theme.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FontAwesome_swift

extension UIColor {

    static var primaryColor: UIColor {
        return UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
    }

    static var secondaryColor: UIColor {
        return UIColor(red: 0, green: 0.5, blue: 1, alpha: 1).darker()
    }

    static var tertiaryColor: UIColor {
        return UIColor(red: 0, green: 0.5, blue: 1, alpha: 1).lighter()
    }

    static var backgroundColor: UIColor {
        return UIColor.white
    }

    static var offWhiteColor: UIColor {
        return UIColor(white: 0.96, alpha: 1)
    }

    static var grayColor: UIColor {
        return UIColor.gray
    }

    static var lightGrayColor: UIColor {
        return UIColor(white: 0.922, alpha: 1)
    }

    static var shadowColor: UIColor {
        return UIColor.black
    }
}

typealias FA = FontAwesome

extension UIImage {
    static func icon(named name: FA) -> UIImage {
        return UIImage.fontAwesomeIcon(
            name: name,
            style: .solid,
            textColor: .primaryColor,
            size: CGSize(width: 250, height: 250)
        )
    }
}
