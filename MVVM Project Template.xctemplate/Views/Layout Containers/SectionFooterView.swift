//
//  SectionFooterView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SectionFooterView<ViewType: UIView>: View {

    let centerView: ViewType

    override init(frame: CGRect) {
        centerView = ViewType()
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        centerView = ViewType()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(centerView)

        let xInset = Stylesheet.Layout.Padding.edgeLeadingTrailing
        let yInset = Stylesheet.Layout.Padding.edgeTopBottom

        centerView.anchorIfNeeded(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, leftConstant: xInset, bottomConstant: yInset, rightConstant: xInset)
        centerView.anchorIfNeeded(topAnchor, topConstant: yInset)
        centerView.anchorCenterXToSuperview()

        heightAnchor.constraint(greaterThanOrEqualToConstant: 28).isActive = true
    }

    override func themeDidChange(_ theme: Theme) {
        super.themeDidChange(theme)
        backgroundColor = .groupTableViewBackground
    }
}
