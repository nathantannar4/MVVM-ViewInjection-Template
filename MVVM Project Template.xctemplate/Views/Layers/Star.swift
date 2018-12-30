//
//  Star.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class StarView: UIView {
    final override class var layerClass: AnyObject.Type {
        return Star.self
    }

    // MARK: - Properties

    var pointyness: CGFloat {
        get { return starLayer.pointyness }
        set { starLayer.pointyness = newValue }
    }

    var fillColor: CGColor? {
        get { return starLayer.fillColor }
        set { starLayer.fillColor = newValue }
    }

    var borderColor: CGColor? {
        get { return starLayer.strokeColor }
        set { starLayer.strokeColor = newValue }
    }

    private var starLayer: Star {
        return layer as! Star
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    // MARK: - View Life Cycle

    func viewDidLoad() {
        tintColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        fillColor = tintColor.cgColor
        borderColor = tintColor.cgColor
    }
}

class Star: CAShapeLayer {

    // MARK: - Properties

    var pointyness: CGFloat = 2 {
        didSet {
            layoutSublayers()
        }
    }

    // MARK: - Initialization

    override init() {
        super.init()
        layerDidLoad()
    }

    override init(layer: Any) {
        super.init(layer: layer)
        layerDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layerDidLoad()
    }

    func layerDidLoad() {
        contentsScale = UIScreen.main.scale
    }

    // MARK: - Layer Life Cycle

    override func layoutSublayers() {
        super.layoutSublayers()
        path = drawStarBezier(in: bounds).cgPath
    }

    // MARK: - Path Helpers

    private func degree2radian(_ value: CGFloat) -> CGFloat {
        return CGFloat(Double.pi) * value / 180
    }

    private func polygonPointArray(sides: Int, x: CGFloat, y: CGFloat, radius: CGFloat, adjustment: CGFloat = 0) -> [CGPoint] {
        let angle = degree2radian(360 / CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r  = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i) + degree2radian(adjustment))
            let ypo = cy - r * sin(angle * CGFloat(i) + degree2radian(adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i -= 1
        }
        return points
    }

    private func starPath(x: CGFloat, y: CGFloat, radius: CGFloat, sides:Int, startAngle: CGFloat = 0) -> CGPath {
        let adjustment = startAngle + CGFloat(360 / sides / 2)
        let path = CGMutablePath()
        let points = polygonPointArray(sides: sides, x: x, y: y, radius: radius, adjustment: startAngle)
        let cpg = points[0]
        let points2 = polygonPointArray(sides: sides, x: x, y: y, radius: radius * pointyness, adjustment: CGFloat(adjustment))
        var i = 0
        path.move(to: CGPoint(x: cpg.x, y: cpg.y))
        for p in points {
            path.addLine(to: CGPoint(x: points2[i].x, y: points2[i].y))
            path.addLine(to: CGPoint(x: p.x, y: p.y))
            i += 1
        }
        path.closeSubpath()
        return path
    }

    private func drawStarBezier(in bounds: CGRect) -> UIBezierPath {

        let radius = min(bounds.width, bounds.height) / 4.75
        let yOffset = radius / 4
        let sides = 5
        let startAngle = CGFloat(-1 * (90 / sides))
        let path = starPath(x: bounds.midX, y: bounds.midY + yOffset, radius: radius, sides: sides, startAngle: startAngle)
        return UIBezierPath(cgPath: path)
    }
}
