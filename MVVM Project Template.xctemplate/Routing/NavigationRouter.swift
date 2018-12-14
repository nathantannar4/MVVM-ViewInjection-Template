//
//  NavigationRouter.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Swinject

class NavigationCoordinator: Coordinator {

    // MARK: - Properties

    var mainController: UIViewController {
        return navigationController
    }

    var container: Container

    let navigationController: NavigationController

    // MARK: - Init

    init(in container: Container) {
        self.container = container
        self.navigationController = NavigationController()
    }
}
