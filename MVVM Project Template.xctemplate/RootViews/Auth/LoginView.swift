//
//  LoginView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginView: View {

    enum Action: String {
        case didTapCancel
        case didTapForgotPassword
        case didTapTerms
        case didTapLogin
        case didTapFacebookLogin
        case didTapGoogleLogin
        case didTapSignUp

        var selector: Selector {
            switch self {
            case .didTapCancel:
                return #selector(LoginView.didTapCancel)
            case .didTapForgotPassword:
                return #selector(LoginView.didTapForgotPassword)
            case .didTapTerms:
                return #selector(LoginView.didTapTerms)
            case .didTapLogin:
                return #selector(LoginView.didTapLogin)
            case .didTapFacebookLogin:
                return #selector(LoginView.didTapFacebookLogin)
            case .didTapGoogleLogin:
                return #selector(LoginView.didTapGoogleLogin)
            case .didTapSignUp:
                return #selector(LoginView.didTapSignUp)
            }
        }
    }

    // MARK: - Properties

    fileprivate var actionEmitter = PublishSubject<LoginView.Action>()

    // MARK: - Subviews

    private let titleLabel = UILabel(style: Stylesheet.Labels.title) {
        $0.text = "Welcome Back"
        $0.textAlignment = .left
    }

    private let subtitleLabel = UILabel(style: Stylesheet.Labels.subtitle) {
        $0.text = "Please sign in to continue"
        $0.textAlignment = .left
    }

    fileprivate let emailField = AnimatedTextField(style: Stylesheet.TextFields.email)
    private let emailIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.at)
    }

    fileprivate let passwordField = AnimatedTextField(style: Stylesheet.TextFields.password)
    private let passwordIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.lock)
    }

    private lazy var cancelButton = UIButton(style: Stylesheet.Buttons.regular) {
        $0.setTitle(.localize(.cancel), for: .normal)
        $0.addTarget(self, action: Action.didTapCancel.selector, for: .touchUpInside)
    }

    private lazy var forgotPasswordButton = UIButton(style: Stylesheet.Buttons.regular) {
        $0.setTitle(.localize(.forgotPassword), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.contentHorizontalAlignment = .center
        $0.addTarget(self, action: Action.didTapForgotPassword.selector, for: .touchUpInside)
    }

    private lazy var termsButton = UIButton(style: Stylesheet.Buttons.termsAndConditions) {
        $0.addTarget(self, action: Action.didTapTerms.selector, for: .touchUpInside)
    }

    fileprivate lazy var loginButton = FluidButton(style: Stylesheet.FluidButtons.primary) {
        $0.setTitle(.localize(.login), for: .normal)
        $0.addTarget(self, action: Action.didTapLogin.selector, for: .touchUpInside)
    }

    //    private lazy var facebookLoginButton = UIButton(style: Stylesheet.Buttons.facebook) {
    //        $0.addTarget(self, action: Action.didTapFacebookLogin.selector, for: .touchUpInside)
    //    }
    //
    //    private lazy var googleLoginButton = UIButton(style: Stylesheet.Buttons.google) {
    //        $0.addTarget(self, action: Action.didTapLogin.selector, for: .touchUpInside)
    //    }

    private lazy var signUpButton = UIButton(style: Stylesheet.Buttons.signUp) {
        $0.addTarget(self, action: Action.didTapSignUp.selector, for: .touchUpInside)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        [cancelButton, titleLabel, subtitleLabel, emailIconView, emailField,
         passwordField, passwordIconView, forgotPasswordButton, termsButton,
         signUpButton, loginButton].forEach { addSubview($0) }

        emailField.delegate = self
        passwordField.delegate = self

        cancelButton.anchor(layoutMarginsGuide.topAnchor, left: layoutMarginsGuide.leftAnchor, topConstant: 6, leftConstant: 6, widthConstant: 50, heightConstant: 30)

        titleLabel.anchor(layoutMarginsGuide.topAnchor, left: layoutMarginsGuide.leftAnchor, right: layoutMarginsGuide.rightAnchor, topConstant: 50, leftConstant: 12, rightConstant: 12, heightConstant: 40)

        subtitleLabel.anchorBelow(titleLabel, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 30)

        emailField.anchor(titleLabel.bottomAnchor, left: layoutMarginsGuide.leftAnchor, bottom: nil, right: layoutMarginsGuide.rightAnchor, topConstant: 75, leftConstant: 50, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 50)

        emailIconView.anchorLeftOf(emailField, topConstant: 20, bottomConstant: 0, rightConstant: 8)
        emailIconView.anchorAspectRatio()

        passwordField.anchorBelow(emailField, bottom: nil, topConstant: 16, bottomConstant: 0, heightConstant: 50)

        passwordIconView.anchorLeftOf(passwordField, topConstant: 20, bottomConstant: 0, rightConstant: 8)
        passwordIconView.anchorAspectRatio()

        forgotPasswordButton.anchorCenterXToSuperview()
        forgotPasswordButton.anchor(passwordField.bottomAnchor, topConstant: 12, heightConstant: 15)

        signUpButton.anchorAbove(termsButton, heightConstant: 30)

        termsButton.anchorAbove(loginButton, heightConstant: 30)

        loginButton.anchor(left: leftAnchor, bottom: keyboardLayoutGuide.topAnchor, right: rightAnchor, heightConstant: 44)

        let safeAreaView = UIView()
        safeAreaView.backgroundColor = .white
        addSubview(safeAreaView)
        safeAreaView.anchor(loginButton.bottomAnchor, left: loginButton.leftAnchor, bottom: bottomAnchor, right: loginButton.rightAnchor)
    }
    
    // MARK: - User Actions

    @objc
    private func didTapCancel() {
        actionEmitter.onNext(.didTapCancel)
    }

    @objc
    private func didTapForgotPassword() {
        actionEmitter.onNext(.didTapForgotPassword)
    }

    @objc
    private func didTapTerms() {
        actionEmitter.onNext(.didTapTerms)
    }

    @objc
    private func didTapLogin() {
        actionEmitter.onNext(.didTapLogin)
    }

    @objc
    private func didTapFacebookLogin() {
        actionEmitter.onNext(.didTapFacebookLogin)
    }

    @objc
    private func didTapGoogleLogin() {
        actionEmitter.onNext(.didTapGoogleLogin)
    }

    @objc
    private func didTapSignUp() {
        actionEmitter.onNext(.didTapSignUp)
    }
}

extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            return passwordField.becomeFirstResponder()
        } else {
            if loginButton.isEnabled {
                actionEmitter.onNext(.didTapLogin)
            }
            return textField.resignFirstResponder()
        }
    }
}

extension Reactive where Base: LoginView {

    var selector: PublishSubject<LoginView.Action> {
        return base.actionEmitter
    }

    var email: ControlProperty<String?> {
        return base.emailField.rx.text
    }

    var password: ControlProperty<String?> {
        return base.passwordField.rx.text
    }

    var isLoginButtonEnabled: Binder<Bool> {
        return base.loginButton.rx.isEnabled
    }
}
