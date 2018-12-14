//
//  FluidButton.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class FluidButton: ControlElement, Roundable {

    enum PropertyKey: String, CaseIterable {
        case backgroundColor, title, attributedTitle, titleColor, image
    }

    // MARK: - Properties

    var roundingMethod: RoundingMethod = .none

    var roundedCorners: UIRectCorner = .allCorners

    private var animator: UIViewPropertyAnimator?
    private var properties: [ElementState:[PropertyKey:Any]] = [
        ElementState.normal: [:],
        ElementState.highlighted: [:],
        ElementState.disabled: [:],
    ]

    // MARK: - Views

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        return stackView
    }()

    let titleLabel = UILabel(style: Stylesheet.Labels.description) {
        $0.font = Stylesheet.Fonts.buttonFont
        $0.textAlignment = .center
    }

    let imageView = UIImageView(style: Stylesheet.ImageViews.fitted)

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
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        setupConstraints()
    }

    func setupConstraints() {
        stackView.fillSuperview()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRounding()
    }

    // MARK: - State Methods

    override func stateDidChange() {
        super.stateDidChange()
        if let color = properties[currentState]?[.backgroundColor] as? UIColor {
            backgroundColor = color
        }
        if let color = properties[currentState]?[.titleColor] as? UIColor {
            titleLabel.textColor = color
            imageView.tintColor = color
        }
        if let title = properties[currentState]?[.title] as? String {
            titleLabel.text = title
        }
        if let attributedTitle = properties[currentState]?[.attributedTitle] as? NSAttributedString {
            titleLabel.attributedText = attributedTitle
        }
        if let image = properties[currentState]?[.image] as? UIImage {
            imageView.image = image
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
        properties[.disabled]?[.backgroundColor] = color?.lighter(by: 5)
        properties[.disabled]?[.titleColor] = titleColor.withAlphaComponent(0.3)
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
