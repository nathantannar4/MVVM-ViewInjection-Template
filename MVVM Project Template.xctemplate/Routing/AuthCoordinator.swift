//
//  AuthCoordinator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Swinject

final class AuthCoordinator: NavigationCoordinator, Coordinatable {

    private var modelNavigationController: UINavigationController!

    typealias RouteType = AuthRoute

    // MARK: - Init

    init(initialRoute: RouteType, in container: Container) {
        super.init(in: container)
        let rootVC = container.resolve(LoginController.self)!
        navigationController.pushViewController(rootVC, animated: false)
    }

    func navigate(to route: AuthRoute) {
        switch route {
        case .eula:
            let rootVC = container.resolve(EULAController.self)!
            modelNavigationController = NavigationController(rootViewController: rootVC)
            navigationController.present(modelNavigationController, animated: true, completion: nil)
        case .login:
            let loginVC = container.resolve(LoginController.self)!
            navigationController.pushViewController(loginVC, animated: true)
        case .signUp:
            let signUpVC = container.resolve(SignUpController.self)!
            navigationController.pushViewController(signUpVC, animated: true)
        }
    }
}
