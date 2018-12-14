//
//  CALayer.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import CoreGraphics

private enum Constants {
    static let contentLayerName = "contentLayer"
}

extension CALayer {
    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?
                .filter { $0.frame.equalTo(bounds) }
                .forEach { $0.roundCorners(radius: cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == Constants.contentLayerName {
                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = Constants.contentLayerName
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }

    func addShadow() {
        shadowOffset = CGSize(width: 0, height: 3)
        shadowOpacity = 0.4
        shadowRadius = 6
        shadowColor = UIColor.black.cgColor
        masksToBounds = false
        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }

    func roundCorners(radius: CGFloat) {
        cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }

    func removeShadow() {
        shadowOffset = .zero
        shadowOpacity = 0
        shadowRadius = 0
    }
}
