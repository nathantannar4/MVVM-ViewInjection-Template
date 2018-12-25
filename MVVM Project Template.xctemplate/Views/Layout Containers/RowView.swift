//
//  RowView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RowView<LeftViewType: UIView, RightViewType: UIView, AccessoryViewType: UIView>: View {

    let leftView: LeftViewType
    let rightView: RightViewType
    let accessoryView: AccessoryViewType

    override init(frame: CGRect) {
        leftView = LeftViewType()
        rightView = RightViewType()
        accessoryView = AccessoryViewType()
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        leftView = LeftViewType()
        rightView = RightViewType()
        accessoryView = AccessoryViewType()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(leftView, rightView, accessoryView)

        let xInset = Stylesheet.Layout.Padding.edgeLeadingTrailing
        let yInset = Stylesheet.Layout.Padding.edgeTopBottom
        let spacing = Stylesheet.Layout.Padding.subviewSpacing

        leftView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset)
        leftView.anchorCenterYToSuperview()
        leftView.anchor(left: leftAnchor, right: accessoryView.leftAnchor, leftConstant: xInset, rightConstant: spacing)
        leftView.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
        leftView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )

        rightView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset)
        rightView.anchor(left: leftView.rightAnchor, right: rightAnchor, leftConstant: spacing, rightConstant: xInset)
        rightView.anchorCenterYToSuperview()

        accessoryView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset, widthConstant: 0)
        accessoryView.anchorCenterYToSuperview()
        accessoryView.anchor(right: rightAnchor, rightConstant: xInset)
        accessoryView.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
        accessoryView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )

        heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
    }
}

