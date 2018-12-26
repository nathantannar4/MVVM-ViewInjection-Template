//
//  GridView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class GridView<TopViewType: UIView, BottomViewType: UIView, LeftViewType: UIView, RightViewType: UIView>: View {

    let topView = TopViewType()
    let bottomView = BottomViewType()
    let leftView = LeftViewType()
    let rightView = RightViewType()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews(topView, bottomView, leftView, rightView)

        topView.anchorIfNeeded(left: leftAnchor)
        topView.anchor(topAnchor, left: leftView.rightAnchor, bottom: centerYAnchor, right: rightView.leftAnchor)

        bottomView.anchorIfNeeded(right: rightAnchor)
        bottomView.anchor(centerYAnchor, left: leftView.rightAnchor, bottom: bottomAnchor, right: rightView.leftAnchor)

        leftView.anchorIfNeeded(topAnchor, bottom: bottomAnchor)
        leftView.anchorCenterYToSuperview()
        leftView.anchor(left: leftAnchor, right: topView.leftAnchor)

        rightView.anchorIfNeeded(topAnchor, bottom: bottomAnchor)
        rightView.anchor(left: topView.rightAnchor, right: rightAnchor)
        rightView.anchorCenterYToSuperview()
    }
}
