//
//  LoginViewController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift

final class LoginController: ViewModelController<AuthViewModel, AccessoryViewWrapped<ScrollViewWrapped<LoginView>, LoginAccessoryView>> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // If pushing a UIViewController onto the stack, unhide the UINavigationBar
        guard navigationController?.viewControllers.last != self else { return }
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        rootView.wrappedView.wrappedView.rx.selector.subscribe { [weak self] event in
            switch event {
            case .next(let action):
                switch action {
                case .didTapForgotPassword:
                    self?.viewModel.presentForgotPassword()
                case .didTapCancel:
                    self?.dismiss(animated: true, completion: nil)
                }
            case .error, .completed:
                break
            }
        }.disposed(by: disposeBag)

        rootView.accessoryView.rx.selector.subscribe { [weak self] event in
            switch event {
            case .next(let action):
                switch action {
                case .didTapLogin:
                    self?.viewModel.login()
                case .didTapSignUp:
                    self?.viewModel.presentSignUp()
                case .didTapTerms:
                    self?.viewModel.presentTermsOfUse()
                case .didTapFacebookLogin:
                    self?.viewModel.facebookLogin()
                case .didTapGoogleLogin:
                    self?.viewModel.googleLogin()
                }
            case .error, .completed:
                break
            }
        }.disposed(by: disposeBag)


        (viewModel.email <-> rootView.wrappedView.wrappedView.rx.email).disposed(by: disposeBag)
        (viewModel.password <-> rootView.wrappedView.wrappedView.rx.password).disposed(by: disposeBag)
        viewModel.isLoginEnabled.bind(to: rootView.accessoryView.rx.isLoginButtonEnabled).disposed(by: disposeBag)
    }
}
