//
//  ControlElement.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ControlElement: UIControl, FeedbackGeneratable {
    enum ElementState: CaseIterable {
        case normal, highlighted, disabled
    }

    private(set) var currentState: ElementState = .normal

    override var isHighlighted: Bool {
        didSet {
            let newState: ElementState = isHighlighted ? .highlighted : .normal
            setState(newState)
        }
    }

    override var isEnabled: Bool {
        didSet {
            let newState: ElementState = isEnabled ? .normal : .disabled
            setState(newState)
        }
    }

    var isFeedbackEnabled: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFeedback()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFeedback()
    }

    final func setState(_ newState: ElementState) {
        currentState = newState
        stateDidChange()
    }

    func stateDidChange() {
        
    }

    func valueDidChange() {
        sendActions(for: .valueChanged)
    }

    private func setupFeedback() {
        addTarget(self, action: #selector(handleFeedbackIfNeeded), for: [.touchDown, .touchDragEnter])
    }

    @objc
    private func handleFeedbackIfNeeded() {
        guard isFeedbackEnabled else { return }
        generateSelectionFeedback()
    }
}
