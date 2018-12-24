//
//  Chevron.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DisclosureIndicator: UIView {
    override class var layerClass: AnyObject.Type {
        return Chevron.self
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 15, height: 15)
    }
}

final class Chevron: CAShapeLayer {
    enum Direction {
        case left, right, top, bottom
    }

    var tintColor: UIColor = UIColor(white: 0.8, alpha: 1) {
        didSet {
            strokeColor = tintColor.cgColor
        }
    }

    var direction: Direction = .right {
        didSet {
            layoutSublayers()
        }
    }

    override init() {
        super.init()
        layerDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layerDidLoad()
    }

    private func layerDidLoad() {
        lineCap = .round
        fillColor = nil
        strokeColor = tintColor.cgColor
    }

    override func layoutSublayers() {
        super.layoutSublayers()
        lineWidth = bounds.height / 8
        path = getPath().cgPath
    }

    private func getPath() -> UIBezierPath {
        let path = UIBezierPath()
        let start: CGPoint
        let mid: CGPoint
        let end: CGPoint
        switch direction {
        case .top:
            start = CGPoint(x: lineWidth, y: bounds.midY)
            mid = CGPoint(x: bounds.midX, y: lineWidth)
            end = CGPoint(x: bounds.maxX - lineWidth, y: bounds.midY)
        case .bottom:
            start = CGPoint(x: lineWidth, y: bounds.midY)
            mid = CGPoint(x: bounds.midX, y: bounds.maxY - lineWidth)
            end = CGPoint(x: bounds.maxX - lineWidth, y: bounds.midY)
        case .left:
            start = CGPoint(x: bounds.midX, y: lineWidth)
            mid = CGPoint(x: lineWidth, y: bounds.midY)
            end = CGPoint(x: bounds.midX, y: bounds.maxY - lineWidth)
        case .right:
            start = CGPoint(x: bounds.midX, y: lineWidth)
            mid = CGPoint(x: bounds.maxX - lineWidth, y: bounds.midY)
            end = CGPoint(x: bounds.midX, y: bounds.maxY - lineWidth)
        }
        path.move(to: start)
        path.addLine(to: mid)
        path.addLine(to: end)
        path.addClip()
        return path
    }
}
