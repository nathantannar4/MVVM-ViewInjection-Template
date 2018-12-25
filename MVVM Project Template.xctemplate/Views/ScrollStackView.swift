//
//  ScrollStackView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ScrollStackView: UIScrollView, IView {

    // MARK: - Properties

    var axis: NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = axis
        }
    }

    var alignment: UIStackView.Alignment = .fill {
        didSet {
            stackView.alignment = alignment
        }
    }

    var spacing: CGFloat = 0 {
        didSet {
            stackView.spacing = spacing
        }
    }

    var distribution: UIStackView.Distribution = .fill {
        didSet {
            stackView.distribution = distribution
        }
    }

    var arrangedViewInsets: UIEdgeInsets = .zero {
        didSet {
            arrangedSubviewInsetsDidChange()
        }
    }

    // MARK: - Views

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = 0
        view.distribution = .fill
        return view
    }()

    private var stackViewConstaints: [NSLayoutConstraint]!

    required override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        subscribeToThemeChanges()
        alwaysBounceVertical = true
        keyboardDismissMode = .interactive
        addSubview(stackView)
        stackViewConstaints = stackView.anchor(topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stackViewConstaints.append(stackView.anchorWidthToItem(self))
    }

    func viewWillAppear(_ animated: Bool) {
        interfaceSubviews.forEach { $0.viewWillAppear(animated) }
    }

    func viewDidAppear(_ animated: Bool) {
        interfaceSubviews.forEach { $0.viewDidAppear(animated) }
    }

    func viewWillDisappear(_ animated: Bool) {
        interfaceSubviews.forEach { $0.viewWillDisappear(animated) }
    }

    func viewDidDisappear(_ animated: Bool) {
        interfaceSubviews.forEach { $0.viewDidDisappear(animated) }
    }
    
    func addArrangedSubview(_ subview: UIView) {
        stackView.addArrangedSubview(subview)
    }

    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }

    func insertArrangedSubview(_ view: UIView, at index: Int) {
        stackView.insertArrangedSubview(view, at: index)
    }

    func removeArrangedSubview(_ subview: UIView) {
        stackView.removeArrangedSubview(subview)
    }

    func removeAllSubviews() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    private func arrangedSubviewInsetsDidChange() {
        stackViewConstaints[0].constant = arrangedViewInsets.top
        stackViewConstaints[1].constant = arrangedViewInsets.left
        stackViewConstaints[2].constant = -arrangedViewInsets.bottom
        stackViewConstaints[3].constant = -arrangedViewInsets.right
        stackViewConstaints[4].constant = -arrangedViewInsets.horizontal
        layoutIfNeeded()
    }

    // MARK: - Theme Updates

    func themeDidChange(_ theme: Theme) {
        backgroundColor = .white
    }
}
