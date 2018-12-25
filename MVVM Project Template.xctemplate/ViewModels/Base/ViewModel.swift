//
//  ViewModel.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias ViewModel = BaseViewModel & IViewModel

class BaseViewModel: NSObject {

    // MARK: - Properties

    let appViewModel: AppViewModel

    required init(appViewModel: AppViewModel) {
        self.appViewModel = appViewModel
        super.init()
        viewModelDidLoad()
    }

    func viewModelDidLoad() {

    }
}
