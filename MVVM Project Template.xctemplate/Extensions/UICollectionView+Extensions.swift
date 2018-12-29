//
//  UICollectionView+Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on 3/11/18.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UICollectionView {

    enum SupplementaryViewKind: String {
        case header = "UICollectionElementKindSectionHeader"
        case footer = "UICollectionElementKindSectionFooter"
    }

    func registerCellClass<T>(_ cellClass: T.Type) where T: IReuseIdentifiable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: IReuseIdentifiable {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func dequeueReusableSupplementaryView<T>(_ cellClass: T.Type, ofKind kind: SupplementaryViewKind, for indexPath: IndexPath) -> T where T: IReuseIdentifiable {
        return dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
