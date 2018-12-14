//
//  UITableView+Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on 3/11/18.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UITableView {

    func registerCellClass<T>(_ cellClass: T.Type) where T: IReuseIdentifiable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: IReuseIdentifiable {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func dequeueReusableHeaderFooterView<T>(_ cellClass: T.Type) -> T where T: IReuseIdentifiable {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }

}
