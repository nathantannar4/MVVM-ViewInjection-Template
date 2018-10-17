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
import PinLayout

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

    private let fadeView = GradientView(style: Style<GradientView>.native) {
        $0.colors = [UIColor.white.withAlphaComponent(0.3), UIColor.white]
        $0.locations = [0, 1]
        $0.backgroundColor = .clear
    }

    private let doneButton = FluidButton(style: Stylesheet.FluidButtons.primary) {
        $0.apply(Stylesheet.Views.rounded)
        $0.setTitle(.localize(.done), for: .normal)
        $0.addTarget(self, action: Action.didTapDone.selector, for: .touchUpInside)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(textView)
        addSubview(fadeView)
        addSubview(doneButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let bottomInset = layoutMargins.bottom + 12
        let buttonHeight: CGFloat = 44
        textView.pin.left(12).right(12).top().bottom()
        textView.contentInset.bottom = bottomInset
        doneButton.pin.bottom(bottomInset).height(44).width(150).hCenter()
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
        fadeView.pin.left().bottom().right().height(bottomInset + buttonHeight)
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
