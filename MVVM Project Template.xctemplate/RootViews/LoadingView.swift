//
//  LoadingView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PinLayout

final class LoadingView: View {

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .primaryColor
        addSubview(activityIndicator)
        activityIndicator.anchorCenterToSuperview()
        activityIndicator.anchor(widthConstant: 50, heightConstant: 50)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }

}
