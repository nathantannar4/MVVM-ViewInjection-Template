//
//  NavigationBar.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NavigationBar: BaseNavigationBar {
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(Stylesheet.NavigationBars.primary)
    }
}

class InverseNavigationBar: BaseNavigationBar {
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(Stylesheet.NavigationBars.inversePrimary)
    }
}

class BaseNavigationBar: UINavigationBar, IView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        subscribeToThemeChanges()
    }

    // MARK: - Theme Updates

    func themeDidChange(_ theme: Theme) {

    }
}
