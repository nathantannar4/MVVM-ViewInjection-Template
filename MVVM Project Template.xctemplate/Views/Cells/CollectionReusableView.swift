//
//  CollectionReusableView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CollectionReusableView<ViewType: IReusableView>: UICollectionReusableView, IReuseIdentifiable {

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
        addSubview(wrappedView)
        wrappedView.fillSuperview()
    }
    
}

