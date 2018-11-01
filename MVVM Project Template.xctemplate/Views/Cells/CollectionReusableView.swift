//
//  CollectionReusableView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CollectionReusableView<ViewType: IReusableView>: UICollectionReusableView {

    let wrappedView: ViewType!

    override init(frame: CGRect) {
        wrappedView = ViewType(frame: frame)
        super.init(frame: frame)
        cellDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        wrappedView = ViewType()
        super.init(coder: aDecoder)
        cellDidLoad()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        wrappedView.prepareForReuse()
    }

    func cellDidLoad() {
        addSubview(wrappedView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        wrappedView.frame = bounds
    }

}

