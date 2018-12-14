//
//  Route.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol Route {}

enum AppRoute: Route {
    case dispatch
}

enum AuthRoute: Route {
    case login
    case signUp
    case eula
}
