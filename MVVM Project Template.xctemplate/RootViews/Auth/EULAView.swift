//
//  EULAView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EULAView: View {

    enum Action: String {
        case didTapDone

        var selector: Selector {
            switch self {
            case .didTapDone:
                return #selector(EULAView.didTapDone)
            }
        }
    }

    // MARK: - Properties

    fileprivate var actionEmitter = PublishSubject<EULAView.Action>()

    // MARK: - Views

    fileprivate let textView = UITextView(style: Stylesheet.TextViews.nonEditable) {
        $0.showsVerticalScrollIndicator = false
    }

    private let fadeView = GradientView(style: Stylesheet.GradientViews.white)
    
    private let doneButton = Button(style: Stylesheet.AnimatedButtons.primary) {
        $0.roundingMethod = .complete
        $0.setTitle(.localize(.done), for: .normal)
        $0.addTarget(self, action: Action.didTapDone.selector, for: .touchUpInside)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(textView)
        addSubview(fadeView)
        addSubview(doneButton)

        textView.contentInset.top = layoutMargins.top + 12
        textView.contentInset.bottom = layoutMargins.bottom + 56
        textView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, leftConstant: 12, rightConstant: 12)

        doneButton.anchorCenterXToSuperview()
        doneButton.anchor(bottom: layoutMarginsGuide.bottomAnchor, bottomConstant: 12, widthConstant: 150, heightConstant: 44)

        fadeView.anchor(doneButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }

    // MARK: - Methods

    @objc
    private func didTapDone() {
        actionEmitter.onNext(.didTapDone)
    }
}

extension Reactive where Base: EULAView {

    var selector: PublishSubject<EULAView.Action> {
        return base.actionEmitter
    }

    var eula: ControlProperty<NSAttributedString?> {
        return base.textView.rx.attributedText
    }
}
