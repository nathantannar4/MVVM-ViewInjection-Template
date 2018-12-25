//
//  SearchBar.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    private enum KeyPath: String {
        case searchField, clearButton, cancelButton
    }

    // MARK: - Views

    var textField: UITextField? {
        return value(forKey: KeyPath.searchField.rawValue) as? UITextField
    }

    var clearButton: UIButton? {
        return value(forKey: KeyPath.clearButton.rawValue) as? UIButton
    }

    var cancelButton: UIButton? {
        return value(forKey: KeyPath.cancelButton.rawValue) as? UIButton
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    // MARK: - View Life Cycle

    private func viewDidLoad() {
        placeholder = .localize(.search)
        tintColor = .primaryColor
        barTintColor = .white
        isTranslucent = false
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        if let textfield = textField {
            textfield.textColor = .darkText
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = .white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
    }
    
}
