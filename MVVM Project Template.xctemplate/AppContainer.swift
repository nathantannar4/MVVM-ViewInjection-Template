//
//  AppContainer.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Swinject

typealias AppContainer = Container

extension AppContainer {

    func registerManagers() {
        register(LogService.self) { _ in
            return LogService.shared
        }
        register(NetworkService.self) { _ in
            return NetworkService()
        }
    }

    func registerViewModels() {
        register(AppViewModel.self) { _ in
            return AppViewModel()
        }.inObjectScope(.container)

        register(AuthViewModel.self) { r in
            let appViewModel = r.resolve(AppViewModel.self)!
            return AuthViewModel(appViewModel: appViewModel)
        }

        register(EULAViewModel.self) { r in
            let appViewModel = r.resolve(AppViewModel.self)!
            return EULAViewModel(appViewModel: appViewModel)
        }

        register(EditProfileViewModel.self) { r in
            let appViewModel = r.resolve(AppViewModel.self)!
            return EditProfileViewModel(appViewModel: appViewModel)
        }
    }

    func registerControllers() {

        register(DispatchController.self) { _ in DispatchController() }

        register(EULAController.self) { r in
            let viewModel = r.resolve(EULAViewModel.self)!
            return EULAController(viewModel: viewModel)
        }

        register(LoginController.self) { r in
            let viewModel = r.resolve(AuthViewModel.self)!
            return LoginController(viewModel: viewModel)
        }

        register(SignUpController.self) { r in
            let viewModel = r.resolve(AuthViewModel.self)!
            return SignUpController(viewModel: viewModel)
        }

        register(EditProfileController.self) { r in
            let viewModel = r.resolve(EditProfileViewModel.self)!
            return EditProfileController(viewModel: viewModel)
        }
    }

}
