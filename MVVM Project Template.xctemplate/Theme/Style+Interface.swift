//
//  Style+Interface.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol IStyle: Interface, Class { }

protocol IViewStyle: IStyle {
    var backgroundColor: UIColor? { get set }
    var tintColor: UIColor! { get set }
}

protocol ITextStyle: IViewStyle {
    var textColor: UIColor! { get set }
    var textAlignment: NSTextAlignment { get set }
    var font: UIFont! { get set }
}

protocol ILabelStyle: ITextStyle {
    var numberOfLines: Int { get set }
    var adjustsFontSizeToFitWidth: Bool { get set }
}

protocol ITextViewStyle: ITextStyle {
    var isEditable: Bool { get set }
    var isScrollEnabled: Bool { get set }
}
