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

        leftView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset)
        leftView.anchorCenterYToSuperview()
        leftView.anchor(left: leftAnchor, right: rightView.leftAnchor, leftConstant: xInset, rightConstant: xInset)
        leftView.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )

        rightView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset)
        rightView.anchor(left: leftView.rightAnchor, right: accessoryView.leftAnchor, leftConstant: xInset, rightConstant: 6)
        rightView.anchorCenterYToSuperview()

        accessoryView.anchorIfNeeded(topAnchor, bottom: bottomAnchor, topConstant: yInset, bottomConstant: yInset)
        accessoryView.anchorCenterYToSuperview()
        accessoryView.anchor(right: rightAnchor, rightConstant: xInset)
        accessoryView.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )
        accessoryView.setContentHuggingPriority(
            .defaultHigh,
            for: .horizontal
        )
    }
}

