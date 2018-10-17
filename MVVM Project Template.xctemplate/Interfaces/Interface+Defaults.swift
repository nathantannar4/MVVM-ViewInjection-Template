//
//  Interface+Defaults.swift
//  MVVM-Template
//
//  Created by Nathan Tannar on 2018-10-05.
//  Copyright © 2018 Nathan Tannar. All rights reserved.
//

import UIKit

extension IView {
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

extension IErrorPresenter {
    func presentError(_ error: IError, animated: Bool, completion: (() -> Void)?) {
        let alert = UIAlertController(title: error.title, message: error.body, preferredStyle: .alert)
        alert.addAction(.ok)
        present(alert, animated: true, completion: nil)
    }
}

extension IRoutePresenter {
    func navigate(to route: Route, animated: Bool, completion: (() -> Void)?) {
        AppRouter.shared.navigate(to: route)
    }
}
