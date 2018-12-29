//
//  NSAttributedString+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public extension NSAttributedString {

    func width(considering height: CGFloat) -> CGFloat {

        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        let rect = self.boundingRect(
            with: constraintBox,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return rect.width
    }
    
    static func bold(_ text: String, size: CGFloat = 11, color: UIColor = .black) -> NSAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor : color
        ]
        return NSAttributedString(string: text, attributes: attrs)
    }
    
    static func italic(_ text: String, size: CGFloat = 11, color: UIColor = .black) -> NSAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor : color
        ]
        return NSAttributedString(string: text, attributes: attrs)
    }
    
    static func normal(_ text: String, size: CGFloat = 11, color: UIColor = .black) -> NSAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor : color
        ]
        return NSAttributedString(string: text, attributes: attrs)
    }
    
}

public extension NSMutableAttributedString {
    
    @discardableResult
    func bold(_ text: String, size: CGFloat = 11, color: UIColor = .black) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor : color
        ]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult
    func italic(_ text: String, size: CGFloat = 11, color: UIColor = .black) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: size),
            NSAttributedString.Key.foregroundColor : color
        ]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult
    func normal(_ text: String, font: UIFont = .systemFont(ofSize: 11), color: UIColor = .black) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor : color
        ]
        let normal =  NSMutableAttributedString(string: text, attributes: attrs)
        self.append(normal)
        return self
    }
    
    
}
