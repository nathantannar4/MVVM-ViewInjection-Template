//
//  SignUpView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpAccessoryView: View {

    enum Action: String {
        case didTapTerms
        case didTapSignUp

        var selector: Selector {
            switch self {
            case .didTapTerms:
                return #selector(SignUpAccessoryView.didTapTerms)
            case .didTapSignUp:
                return #selector(SignUpAccessoryView.didTapSignUp)
            }
        }
    }

    // MARK: - Properties

    fileprivate var actionEmitter = PublishSubject<SignUpAccessoryView.Action>()

    // MARK: - Subviews

    private lazy var termsButton = UIButton(style: Stylesheet.Buttons.termsAndConditions) {
        $0.addTarget(self, action: Action.didTapTerms.selector, for: .touchUpInside)
    }

    fileprivate lazy var signUpButton = Button(style: Stylesheet.AnimatedButtons.primary) {
        $0.setTitle(.localize(.signUp), for: .normal)
        $0.addTarget(self, action: Action.didTapSignUp.selector, for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(termsButton, signUpButton)

        termsButton.anchorAbove(signUpButton, top: topAnchor, heightConstant: 30)
        signUpButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, heightConstant: 44)
    }

    // MARK: - User Actions

    @objc
    private func didTapTerms() {
        actionEmitter.onNext(.didTapTerms)
    }

    @objc
    private func didTapSignUp() {
        actionEmitter.onNext(.didTapSignUp)
    }
}

extension Reactive where Base: SignUpAccessoryView {

    var selector: PublishSubject<SignUpAccessoryView.Action> {
        return base.actionEmitter
    }

    var isSignUpEnabled: Binder<Bool> {
        return base.signUpButton.rx.isEnabled
    }
}


final class SignUpView: View {

    // MARK: - Subviews

    private let titleLabel = UILabel(style: Stylesheet.Labels.title) {
        $0.text = .localize(.signUp)
        $0.textAlignment = .left
    }

    private let subtitleLabel = UILabel(style: Stylesheet.Labels.subtitle) {
        $0.text = "Welcome"
        $0.textAlignment = .left
    }

    fileprivate let emailField = AnimatedTextField(style: Stylesheet.TextFields.email)
    private let emailIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.at)
    }

    private let nameField = AnimatedTextField(style: Stylesheet.TextFields.primary) {
        $0.placeholder = .localize(.firstLastName)
    }
    private let nameIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.user)
    }

    private let phoneField = AnimatedTextField(style: Stylesheet.TextFields.phone)
    private let phoneIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.phone)
    }

    fileprivate let passwordField = AnimatedTextField(style: Stylesheet.TextFields.password)
    private let passwordIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.lock)
    }

    private let confirmPasswordField = AnimatedTextField(style: Stylesheet.TextFields.password) {
        $0.placeholder = .localize(.passwordVerify)
    }
    private let confirmPasswordIconView = UIImageView(style: Stylesheet.ImageViews.fitted) {
        $0.image = UIImage.icon(named: FA.lock)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews(titleLabel, subtitleLabel, emailField, emailIconView, nameField, nameIconView, phoneField, phoneIconView, passwordField, passwordIconView, confirmPasswordField, confirmPasswordIconView)

        titleLabel.anchor(layoutMarginsGuide.topAnchor, left: layoutMarginsGuide.leftAnchor, right: layoutMarginsGuide.rightAnchor, topConstant: 12, leftConstant: 12, rightConstant: 12, heightConstant: 25)

        subtitleLabel.anchorBelow(titleLabel, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 25)

        var lastView: UIView = subtitleLabel
        for subview in [emailField, emailIconView, nameField, nameIconView, phoneField, phoneIconView, passwordField, passwordIconView, confirmPasswordField, confirmPasswordIconView] {
            if subview is UIImageView {
                subview.anchorLeftOf(lastView, topConstant: 14, rightConstant: 8)
                subview.anchorAspectRatio()
            } else if subview is UITextField {
                let leftConstant: CGFloat = lastView == subtitleLabel ? (30 + 8) : 0
                subview.anchorBelow(lastView, topConstant: 12, leftConstant: leftConstant, heightConstant: 44)
                lastView = subview
            }
        }
    }
}

extension SignUpView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            return nameField.becomeFirstResponder()
        } else if textField == nameField {
            return phoneField.becomeFirstResponder()
        } else if textField == phoneField {
            return passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            return confirmPasswordField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
}

extension Reactive where Base: SignUpView {

    var email: ControlProperty<String?> {
        return base.emailField.rx.text
    }

    var password: ControlProperty<String?> {
        return base.passwordField.rx.text
    }
}
