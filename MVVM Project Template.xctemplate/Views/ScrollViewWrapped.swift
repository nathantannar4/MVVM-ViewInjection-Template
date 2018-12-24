//
//  WrappedScrollView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ScrollViewWrapped<ViewType: IView>: UIScrollView, IView, IWrapperView {

    let wrappedView: ViewType

    required override init(frame: CGRect) {
        wrappedView = ViewType(frame: frame)
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        wrappedView = ViewType(coder: aDecoder)!
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        keyboardDismissMode = .interactive
        contentInsetAdjustmentBehavior = .never
        addSubview(wrappedView)
        wrappedView.anchor(topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        wrappedView.anchorHeightToItem(self, multiplier: 1.01)
        wrappedView.anchorWidthToItem(self)
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
}
