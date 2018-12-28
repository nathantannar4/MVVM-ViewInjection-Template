//
//  SectionHeaderView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SectionHeaderView<LeftViewType: UIView, RightViewType: UIView>: View {

    let leftView = LeftViewType()
    let rightView = RightViewType()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(leftView, rightView)

        let xInset = Stylesheet.Layout.Padding.edgeLeadingTrailing
        let yInset = Stylesheet.Layout.Padding.edgeTopBottom
        let spacing = Stylesheet.Layout.Padding.subviewSpacing

        leftView.anchorIfNeeded(topAnchor, topConstant: yInset)
        leftView.anchor(left: leftAnchor, bottom: bottomAnchor, leftConstant: xInset, bottomConstant: yInset)
        leftView.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
        leftView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )

        rightView.anchorIfNeeded(topAnchor, topConstant: yInset)
        rightView.anchor(bottom: bottomAnchor, right: rightAnchor, bottomConstant: yInset, rightConstant: xInset)

        rightView.leftAnchor.constraint(greaterThanOrEqualTo: leftView.rightAnchor, constant: spacing).isActive = true

        heightAnchor.constraint(greaterThanOrEqualToConstant: 38)
            .withPriority(.defaultHigh)
            .activated()
    }

    override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        backgroundColor = .groupTableViewBackground
    }
}

