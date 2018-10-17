//
//  AuthViewModel.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift

final class AuthViewModel: ViewModel {

    var email = BehaviorSubject<String?>(value: nil)
    var password = BehaviorSubject<String?>(value: nil)
    var passwordConfirmation = BehaviorSubject<String?>(value: nil)

    lazy var isLoginEnabled: Observable<Bool> = {
        let emailValidation = email.asObservable()
            .map { $0?.isValidEmail == true }
            .share(replay: 1, scope: .whileConnected)

        let passwordValidation = password.asObservable()
            .map { $0?.isEmpty == false }
            .share(replay: 1, scope: .whileConnected)

        return Observable.combineLatest([emailValidation, passwordValidation])
            .map { return !$0.contains(false) }
            .share(replay: 1, scope: .whileConnected)
    }()

    lazy var isSignUpEnabled: Observable<Bool> = {
        let emailValidation = email.asObservable()
            .map { $0?.isValidEmail == true }
            .share(replay: 1, scope: .whileConnected)

        let passwordValidationA = password.asObservable()
            .map { $0?.isEmpty == false }
            .share(replay: 1, scope: .whileConnected)

        let passwordValidationB = Observable.combineLatest(
            [password.asObservable(), passwordConfirmation.asObservable()])
            .map { return $0.first == $0.last }
            .share(replay: 1, scope: .whileConnected)

        return Observable.combineLatest([emailValidation, passwordValidationA, passwordValidationB])
            .map { return !$0.contains(false) }
            .share(replay: 1, scope: .whileConnected)
    }()

    override func viewModelDidLoad() {
        super.viewModelDidLoad()

    }

    func login() {

    }

    func signUp() {

    }

    func facebookLogin() {

    }

    func googleLogin() {

    }

    func presentSignUp() {
        AppRouter.shared.navigate(to: AuthRoute.signUp)
    }

    func presentTermsOfUse() {
        AppRouter.shared.navigate(to: AuthRoute.eula)
    }

    func presentForgotPassword() {

    }
}
