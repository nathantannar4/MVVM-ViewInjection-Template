//
//  Coordinator+Coordinatable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Swinject

protocol Coordinator {
    var mainController: UIViewController { get }
    var container: Container { get set }
}

protocol Coordinatable {
    associatedtype RouteType: Route
    func navigate(to route: RouteType)
}
