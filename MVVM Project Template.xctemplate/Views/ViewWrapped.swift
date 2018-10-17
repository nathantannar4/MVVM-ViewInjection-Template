//
//  ViewView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PinLayout

final class ViewWrapped<ViewType: UIView>: View {

    let wrappedView: ViewType!

    required override init(frame: CGRect) {
        wrappedView = ViewType(frame: frame)
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        wrappedView = ViewType(coder: aDecoder)
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(wrappedView)
        wrappedView.fillSuperview()
        wrappedView.anchorWidthToItem(self)
        wrappedView.anchorHeightToItem(self)
    }
}

