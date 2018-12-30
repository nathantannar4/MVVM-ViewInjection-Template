//
//  Button.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Button: ControlElement, RoundableView {
    private enum PropertyKey: String, CaseIterable {
        case backgroundColor, title, attributedTitle, titleColor, image
    }

    enum ImagePosition {
        case top, bottom, left, right
    }

    // MARK: - Properties

    var roundingMethod: RoundingMethod = .none {
        didSet {
            applyRounding()
        }
    }

    var roundedCorners: UIRectCorner = .allCorners {
        didSet {
            applyRounding()
        }
    }

    private var animator: UIViewPropertyAnimator?
    private var properties: [ElementState:[PropertyKey:Any]] = [
        ElementState.normal: [:],
        ElementState.highlighted: [:],
        ElementState.disabled: [:],
    ]

    var titleImageSpacing: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var imagePosition: ImagePosition = .left {
        didSet {
            setNeedsLayout()
        }
    }

    var adjustImageWhenHighlighted: Bool = true

    override var intrinsicContentSize: CGSize {
        let titleSize = titleLabelSize
        let imageSpan = imageViewSize.width
        switch imagePosition {
        case .left, .right:
            return CGSize(width: titleSize.width + imageSpan + titleImageSpacing, height: max(titleSize.height, imageSpan))
        case .top, .bottom:
            return CGSize(width: max(titleSize.width, imageSpan), height: titleSize.height + imageSpan + titleImageSpacing)
        }
    }

    private var titleLabelSize: CGSize {
        let size = titleLabel.sizeThatFits(bounds.size)
        switch imagePosition {
        case .left, .right:
            return CGSize(width: min(bounds.width / 2, size.width), height: min(bounds.height, size.height))
        case .top, .bottom:
            return CGSize(width: min(bounds.width, size.width), height: min(bounds.height / 2, size.height))
        }
    }

    private var imageViewSize: CGSize {
        let size = imageView.sizeThatFits(bounds.size)
        let maxBounds: CGFloat
        switch imagePosition {
        case .left, .right:
            maxBounds = min(bounds.height, bounds.width / 2)
        case .top, .bottom:
            maxBounds = min(bounds.height / 2, bounds.width)
        }
        let imageSpan = min(maxBounds, min(size.width, size.height))
        return CGSize(width: imageSpan, height: imageSpan)
    }

    // MARK: - Views

    let titleLabel = UILabel(style: Stylesheet.Labels.description) {
        $0.font = Stylesheet.Fonts.buttonFont
        $0.textAlignment = .center
    }

    let imageView = UIImageView(style: Stylesheet.ImageViews.fitted)

    // MARK: - Init

    convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
    }

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
        addSubview(imageView)
        addSubview(titleLabel)
        setTitleColor(.primaryColor, for: .normal)
        setTitleColor(UIColor.primaryColor.withAlphaComponent(0.3), for: .highlighted)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRounding()

        var titleLabelOrigin: CGPoint = .zero
        var imageViewOrigin: CGPoint = .zero

        let titleLabelSize = self.titleLabelSize
        let imageViewSize = self.imageViewSize

        switch contentHorizontalAlignment {
        case .left, .leading:
            switch imagePosition {
            case .top, .bottom:
                imageViewOrigin.x = 0
                titleLabelOrigin.x = 0

            case .left:
                imageViewOrigin.x = 0
                titleLabelOrigin.x = imageViewSize.width + titleImageSpacing

            case .right:
                titleLabelOrigin.x = 0
                imageViewOrigin.x = titleLabelSize.width + titleImageSpacing
            }

        case .right, .trailing:
            switch imagePosition {
            case .top, .bottom:
                imageViewOrigin.x = bounds.width - imageViewSize.width
                titleLabelOrigin.x = bounds.width - titleLabelSize.width

            case .left:
                titleLabelOrigin.x = bounds.width - titleLabelSize.width
                imageViewOrigin.x = titleLabelOrigin.x - titleImageSpacing - imageViewSize.width

            case .right:
                imageViewOrigin.x = bounds.width - imageViewSize.width
                titleLabelOrigin.x = imageViewOrigin.x - titleImageSpacing - titleLabelSize.width
            }

        case .center, .fill:
            switch imagePosition {
            case .top, .bottom:
                imageViewOrigin.x = bounds.midX - imageViewSize.width / 2
                titleLabelOrigin.x = bounds.midX - titleLabelSize.width / 2

            case .left:
                imageViewOrigin.x = bounds.midX - intrinsicContentSize.width / 2
                titleLabelOrigin.x = imageViewOrigin.x + imageViewSize.width + titleImageSpacing

            case .right:
                titleLabelOrigin.x = bounds.midX - intrinsicContentSize.width / 2
                imageViewOrigin.x = titleLabelOrigin.x + titleLabelSize.width + titleImageSpacing
            }
        }

        switch contentVerticalAlignment {
        case .top:
            switch imagePosition {
            case .top:
                imageViewOrigin.y = 0
                titleLabelOrigin.y = imageViewSize.height + titleImageSpacing

            case .bottom:
                titleLabelOrigin.y = 0
                imageViewOrigin.y = titleLabelSize.height + titleImageSpacing

            case .left, .right:
                titleLabelOrigin.y = 0
                imageViewOrigin.y = 0

            }

        case .bottom:
            switch imagePosition {
            case .top:
                imageViewOrigin.y = bounds.height - imageViewSize.height
                titleLabelOrigin.y = imageViewOrigin.y - titleImageSpacing - titleLabelSize.height

            case .bottom:
                titleLabelOrigin.y = bounds.height - titleLabelSize.height
                imageViewOrigin.y = titleLabelOrigin.y - titleImageSpacing - titleLabelSize.height

            case .left, .right:
                titleLabelOrigin.y = bounds.height - titleLabelSize.height
                imageViewOrigin.y = bounds.height - imageViewSize.height

            }

        case .center, .fill:
            switch imagePosition {
            case .top:
                imageViewOrigin.y = bounds.midY - intrinsicContentSize.height / 2
                titleLabelOrigin.y = imageViewOrigin.y + imageViewSize.height + titleImageSpacing

            case .bottom:
                titleLabelOrigin.y = bounds.midY - intrinsicContentSize.height / 2
                imageViewOrigin.y = titleLabelOrigin.y + titleLabelSize.height + titleImageSpacing

            case .left, .right:
                titleLabelOrigin.y = bounds.midY - titleLabelSize.height / 2
                imageViewOrigin.y = bounds.midY - imageViewSize.height / 2

            }
        }
        titleLabel.frame = CGRect(origin: titleLabelOrigin, size: titleLabelSize)
        imageView.frame = CGRect(origin: imageViewOrigin, size: imageViewSize)
    }

    // MARK: - State Methods

    override func stateDidChange() {
        super.stateDidChange()
        updateViewProperties()
    }

    func setTitle(_ title: String?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.title] = title
    }

    func setAttributedTitle(_ attributedTitle: NSAttributedString?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.attributedTitle] = attributedTitle
    }

    func setTitleColor(_ titleColor: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.titleColor] = titleColor
    }

    func setBackgroundColor(_ backgroundColor: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.backgroundColor] = backgroundColor
    }

    func setImage(_ image: UIImage?, for state: ElementState) {
        defer { updateViewProperties() }
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

    private func updateViewProperties() {
        if let color = properties[currentState]?[.backgroundColor] as? UIColor {
            backgroundColor = color
        }
        if let color = properties[currentState]?[.titleColor] as? UIColor {
            titleLabel.textColor = color
            imageView.tintColor = color
        }
        if let title = properties[currentState]?[.title] as? String {
            titleLabel.text = title
            setNeedsLayout()
        }
        if let attributedTitle = properties[currentState]?[.attributedTitle] as? NSAttributedString {
            titleLabel.attributedText = attributedTitle
            setNeedsLayout()
        }
        if let image = properties[currentState]?[.image] as? UIImage {
            imageView.image = image
            setNeedsLayout()
        }
        imageView.alpha = adjustImageWhenHighlighted ? 0.3 : 1
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
