//
//  DispatchController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DispatchController: Controller<LoadingView> {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dispatch()
    }

    private func dispatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            AppRouter.shared.navigate(to: AuthRoute.login)
        }
    }

}
