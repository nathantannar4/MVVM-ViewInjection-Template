//
//  CollectionView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView, IView {

    var flowLayout: UICollectionViewFlowLayout! {
        return collectionViewLayout as? UICollectionViewFlowLayout
    }

    // MARK: - Init

    required init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: frame.width, height: 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: frame, collectionViewLayout: layout)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    // MARK: - View Life Cycle

    func viewDidLoad() {
        subscribeToThemeChanges()
        alwaysBounceVertical = true
    }

    // MARK: - Theme Updates

    func themeDidChange(_ theme: Theme) {
        backgroundColor = .white
    }
}
