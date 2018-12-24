//
//  RoundedView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RoundedView: UIView, RoundableView {
    
    var roundingMethod: RoundingMethod = .complete {
        didSet {
            applyRounding()
        }
    }
    
    var roundedCorners: UIRectCorner = .allCorners {
        didSet {
            applyRounding()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyRounding()
    }
}
