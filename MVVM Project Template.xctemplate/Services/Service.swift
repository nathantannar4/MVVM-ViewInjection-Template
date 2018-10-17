//
//  BaseService.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class Service: NSObject, IService {

    // MARK: - Init

    override init() {
        super.init()
        serviceDidLoad()
    }

    func serviceDidLoad() {

    }
}
