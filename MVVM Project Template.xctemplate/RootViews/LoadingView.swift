//
//  LoadingView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class LoadingView: View {

    private let activityIndicator = ActivitySpinnerIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview(activityIndicator)
        backgroundColor = .primaryColor
        activityIndicator.tintColor = .white
        activityIndicator.anchorCenterToSuperview()
        activityIndicator.anchor(widthConstant: 50, heightConstant: 50)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.startAnimating()
    }
    
}
