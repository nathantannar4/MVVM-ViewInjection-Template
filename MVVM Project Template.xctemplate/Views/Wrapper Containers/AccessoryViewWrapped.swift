//
//  AccessoryViewWrapped.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxKeyboard

final class AccessoryViewWrapped<ViewType: IView, AccessoryViewType: IView>: View, IWrapperView {

    let wrappedView: ViewType
    let accessoryView: AccessoryViewType

    private let disposeBag = DisposeBag()
    private var accessoryViewBottomConstraint: NSLayoutConstraint!

    required override init(frame: CGRect) {
        wrappedView = ViewType(frame: frame)
        accessoryView = AccessoryViewType(frame: .zero)
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        wrappedView = ViewType(coder: aDecoder)!
        accessoryView = AccessoryViewType(coder: aDecoder)!
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(wrappedView)
        addSubview(accessoryView)

        wrappedView.anchor(topAnchor, left: leftAnchor, bottom: accessoryView.topAnchor, right: rightAnchor)
        accessoryViewBottomConstraint = accessoryView.anchor(left: leftAnchor, bottom: layoutMarginsGuide.bottomAnchor, right: rightAnchor).dropFirst().first

        setupBindings()
    }

    private func setupBindings() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                self?.keyboardDidChange(to: height)
        }).disposed(by: disposeBag)
    }

    private func keyboardDidChange(to height: CGFloat) {
        let newConstant = height > 0 ? -height + layoutMargins.bottom : 0
        accessoryViewBottomConstraint.constant = newConstant
        UIView.animate(withDuration: 0) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}
