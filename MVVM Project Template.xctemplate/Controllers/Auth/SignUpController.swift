//
//  SignUpViewController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SignUpController: ViewModelController<AuthViewModel, AccessoryViewWrapped<ScrollViewWrapped<SignUpView>, SignUpAccessoryView>> {

    // MARK: - View Life Cycle

    override func bindToViewModel() {
        super.bindToViewModel()
        rootView.accessoryView.rx.selector.subscribe { [weak self] event in
            switch event {
            case .next(let action):
                switch action {
                case .didTapSignUp:
                    self?.viewModel.signUp()
                case .didTapTerms:
                    self?.viewModel.presentTermsOfUse()
                }
            case .error, .completed:
                break
            }
        }.disposed(by: disposeBag)


        (viewModel.email <-> rootView.wrappedView.wrappedView.rx.email).disposed(by: disposeBag)
        (viewModel.password <-> rootView.wrappedView.wrappedView.rx.password).disposed(by: disposeBag)
        viewModel.isSignUpEnabled.bind(to: rootView.accessoryView.rx.isSignUpEnabled).disposed(by: disposeBag)
    }
}
