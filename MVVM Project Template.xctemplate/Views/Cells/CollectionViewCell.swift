//
//  CollectionViewCell.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CollectionViewCell<ViewType: IReusableView>: UICollectionViewCell, IReuseIdentifiable, IWrapperView {

    class var reuseIdentifier: String {
        return String(describing: self)
    }

    let wrappedView: ViewType

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
        contentView.addSubview(wrappedView)
        wrappedView.fillSuperview()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = wrappedView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
