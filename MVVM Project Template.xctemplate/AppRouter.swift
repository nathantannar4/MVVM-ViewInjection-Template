//
//  AppRouter.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Swinject
import SVProgressHUD

final class AppRouter {
    
    static let shared = AppRouter()

    // MARK: - Properties

    private let container = Container()
    private var childRouter: Router?

    // MARK: - Views

    private(set) var window: AppWindow?

    // MARK: - Init

    private init() {
        registerManagers()
        registerViewModels()
        registerControllers()
    }

    // MARK: - Methods
    
    func start(with options: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        window = AppWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container.resolve(DispatchController.self)
        window?.makeKeyAndVisible()
    }

    func showProgressHUD() {
        SVProgressHUD.show()
    }

    func dismissProgressHUD(_ completion: (() -> Void)?) {
        SVProgressHUD.dismiss(completion: completion)
    }
    
    func navigate(to route: Route, animated: Bool = true, completion: (() -> Void)? = nil) {
        handleCoordination(of: route, animated: animated, completion: completion)
    }

    private func handleCoordination(of route: Route, animated: Bool, completion: (() -> Void)?) {
        assert(Thread.isMainThread)
        switch route {
        case let authRoute as AuthRoute:
            if let router = childRouter as? AuthRouter {
                router.navigate(to: authRoute)
            } else {
                let authRouter = AuthRouter(initialRoute: authRoute, in: container)
                childRouter = authRouter
                window?.switchRootViewController(authRouter.mainController)
            }
        default:
            Log.error("Failed to resolve destination for route: \(route)")
        }
    }
}

extension AppRouter {
    
    private func registerManagers() {
        container.register(LogService.self) { _ in
            return LogService.shared
        }
        container.register(NetworkService.self) { _ in
            return NetworkService()
        }
    }
    
    private func registerViewModels() {
        container.register(AppViewModel.self) { _ in
            return AppViewModel()
        }.initCompleted(viewModelDidLoad)
        container.register(ViewModel.self) { r in
            let viewModel = ViewModel()
            viewModel.appViewModel = r.resolve(AppViewModel.self)
            return viewModel
        }.initCompleted(viewModelDidLoad)
        container.register(AuthViewModel.self) { r in
            let viewModel = AuthViewModel()
            viewModel.appViewModel = r.resolve(AppViewModel.self)
            return viewModel
        }.initCompleted(viewModelDidLoad)
        container.register(EULAViewModel.self) { r in
            let viewModel = EULAViewModel()
            viewModel.appViewModel = r.resolve(AppViewModel.self)
            return viewModel
        }.initCompleted(viewModelDidLoad)
    }

    private func viewModelDidLoad(resolver: Resolver, viewModel: IViewModel) {
        viewModel.viewModelDidLoad()
    }
    
    private func registerControllers() {
        container.register(DispatchController.self) { r in
            return DispatchController()
        }
        container.register(EULAController.self) { r in
            let vc = EULAController()
            vc.viewModel = r.resolve(EULAViewModel.self)
            return vc
        }
        container.register(LoginController.self) { r in
            let vc = LoginController()
            vc.viewModel = r.resolve(AuthViewModel.self)!
            return vc
        }
        container.register(SignUpController.self) { r in
            let vc = SignUpController()
            vc.viewModel = r.resolve(AuthViewModel.self)!
            return vc
        }
    }
    
}
