//
//  FluidButton.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PinLayout

class FluidButton: ControlElement {

    enum PropertyKey: String, CaseIterable {
        case backgroundColor, title, attributedTitle, titleColor, image
    }

    // MARK: - Properties

    var titleLabel: UILabel? {
        return textLabel
    }

    var imageView: UIImageView? {
        return iconView
    }

    private var animator: UIViewPropertyAnimator?
    private var properties: [ElementState:[PropertyKey:Any]] = [
        ElementState.normal: [:],
        ElementState.highlighted: [:],
        ElementState.disabled: [:],
    ]

    // MARK: - Views

    private let textLabel = UILabel(style: Stylesheet.Labels.description) {
        $0.font = Stylesheet.Fonts.buttonFont
        $0.textAlignment = .center
    }

    private let iconView = UIImageView(style: Stylesheet.ImageViews.fitted)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }

    private func controlDidLoad() {

        addTarget(self, action: #selector(touchDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
        addSubview(textLabel)
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.pin.center().width(100%).height(100%)
    }

    // MARK: - State Methods

    override func stateDidChange() {
        super.stateDidChange()
        if let color = properties[currentState]?[.backgroundColor] as? UIColor {
            backgroundColor = color
        }
        if let color = properties[currentState]?[.titleColor] as? UIColor {
            textLabel.textColor = color
            iconView.tintColor = color
        }
        if let title = properties[currentState]?[.title] as? String {
            textLabel.text = title
        }
        if let attributedTitle = properties[currentState]?[.attributedTitle] as? NSAttributedString {
            textLabel.attributedText = attributedTitle
        }
        if let image = properties[currentState]?[.image] as? UIImage {
            iconView.image = image
        }
    }

    func setTitle(_ title: String?, for state: ElementState) {
        defer { stateDidChange() }
        properties[state]?[.title] = title
    }

    func setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: ElementState) {
        defer { stateDidChange() }
        properties[state]?[.attributedTitle] = attributedTitle
    }

    func setTitleColor(_ titleColor: UIColor?, for state: ElementState) {
        defer { stateDidChange() }
        properties[state]?[.titleColor] = titleColor
    }

    func setBackgroundColor(_ backgroundColor: UIColor?, for state: ElementState) {
        defer { stateDidChange() }
        properties[state]?[.backgroundColor] = backgroundColor
    }

    func setImage(_ image: UIImage?, for state: ElementState) {
        defer { stateDidChange() }
        properties[state]?[.image] = image
    }

    func setPrimaryColor(to color: UIColor?) {
        defer { stateDidChange() }
        properties[.normal]?[.backgroundColor] = color
        let titleColor = (color?.isLight ?? true) ? UIColor.black : UIColor.white
        properties[.normal]?[.titleColor] = titleColor
        let accentColor = (color?.isLight ?? true) ? color?.darker() : color?.lighter()
        properties[.highlighted]?[.backgroundColor] = accentColor
        properties[.highlighted]?[.titleColor] = titleColor.withAlphaComponent(0.3)
    }

    // MARK: - Animations

    @objc
    private func touchDown() {
        animator?.stopAnimation(true)
        setState(.highlighted)
    }

    @objc
    private func touchUp() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: { [weak self] in
            self?.setState(.normal)
        })
        animator?.startAnimation()
    }

}
