//
//  Slider.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Slider: ControlElement {
    var value: Double = 0 {
        didSet {
            stateDidChange()
            valueDidChange()
        }
    }

    var minValue: Double = 0 {
        didSet {
            innerLayer.strokeEnd = CGFloat(value / (maxValue - minValue))
            layoutThumbLayer(for: layer.bounds)
        }
    }

    var maxValue: Double = 100 {
        didSet {
            innerLayer.strokeEnd = CGFloat(value / (maxValue - minValue))
            layoutThumbLayer(for: layer.bounds)
        }
    }

    var tickCount: Int = 0 {
        didSet {
            layoutTickLayer(for: layer.bounds)
        }
    }

    var thumbRadiusPadding: CGFloat = 0 {
        didSet {
            layoutThumbLayer(for: layer.bounds)
        }
    }

    var onTintColor: UIColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1) {
        didSet {
            innerLayer.strokeColor = onTintColor.cgColor
        }
    }

    var offTintColor: UIColor = UIColor(white: 0.922, alpha: 1) {
        didSet {
            trackLayer.strokeColor = offTintColor.cgColor
        }
    }

    var thumbTintColor: UIColor = .white {
        didSet {
            thumbLayer.fillColor = thumbTintColor.cgColor
        }
    }

    var thumbImage: CGImage? {
        didSet {
            thumbLayer.contents = thumbImage
        }
    }

    var trackHeightScale: CGFloat = 0.2 {
        didSet {
            layoutTrackLayer(for: layer.bounds)
            layoutInnerLayer(for: layer.bounds)
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 130, height: 30)
    }

    let trackLayer = CAShapeLayer()
    let innerLayer = CAShapeLayer()
    let thumbLayer = CAShapeLayer()
    let tickLayer = CAShapeLayer()
    let tickReplicatorLayer = CAReplicatorLayer()

    private var isTouchDown: Bool = false
    private var touchDownLoacation: CGPoint = .zero

    convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }

    func controlDidLoad() {
        layer.addSublayer(tickReplicatorLayer)
        layer.addSublayer(trackLayer)
        layer.addSublayer(innerLayer)
        layer.addSublayer(thumbLayer)
        tickReplicatorLayer.addSublayer(tickLayer)

        trackLayer.lineCap = .round
        trackLayer.fillColor = nil
        trackLayer.strokeColor = offTintColor.cgColor

        innerLayer.strokeEnd = 0
        innerLayer.lineCap = .round
        innerLayer.fillColor = nil
        innerLayer.strokeColor = onTintColor.cgColor

        thumbLayer.fillColor = thumbTintColor.cgColor
        thumbLayer.shadowColor = UIColor.gray.cgColor
        thumbLayer.shadowRadius = 2
        thumbLayer.shadowOpacity = 0.4
        thumbLayer.shadowOffset = CGSize(width: 0.75, height: 2)
        thumbLayer.contentsGravity = .resizeAspect

        tickLayer.lineWidth = 2
        tickLayer.lineCap = .round
        tickLayer.fillColor = nil
        tickLayer.strokeColor = offTintColor.cgColor

        layoutSublayers(of: layer)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layoutTrackLayer(for: layer.bounds)
        layoutInnerLayer(for: layer.bounds)
        layoutThumbLayer(for: layer.bounds)
        layoutTickLayer(for: layer.bounds)
    }

    func layoutTrackLayer(for bounds: CGRect) {
        trackLayer.path = getTrackPath(for: bounds).cgPath
        trackLayer.lineWidth = bounds.height * trackHeightScale
    }

    func layoutInnerLayer(for bounds: CGRect) {
        innerLayer.path = getTrackPath(for: bounds).cgPath
        innerLayer.lineWidth = bounds.height * trackHeightScale
    }

    func layoutThumbLayer(for bounds: CGRect) {
        let size = getThumbSize()
        let origin = getThumbOrigin(for: size.width)
        thumbLayer.frame = CGRect(origin: origin, size: size)
        thumbLayer.path = getThumbPath(for: size).cgPath
    }

    private func layoutTickLayer(for bounds: CGRect) {
        tickReplicatorLayer.instanceCount = tickCount

        guard tickCount > 0 else { return }

        let dx = bounds.width / CGFloat(tickCount - 1)

        tickLayer.frame = bounds
        tickLayer.path = getTickPath(for: bounds).cgPath

        tickReplicatorLayer.frame = bounds
        tickReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(dx, 0, 0)
    }

    override func stateDidChange() {
        super.stateDidChange()
        innerLayer.strokeEnd = CGFloat(value / (maxValue - minValue))
    }

    func setValue(_ newValue: Double, animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        value = newValue
        layoutThumbLayer(for: layer.bounds)
        CATransaction.commit()
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        touchDownLoacation = location
        isTouchDown = thumbLayer.frame.contains(location)
        layoutThumbLayer(for: layer.bounds)
        return isTouchDown
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        let dx = Double(location.x - touchDownLoacation.x)
        let dv = (maxValue - minValue) * dx / Double(bounds.width)
        let newValue = min(max(value + dv, minValue), maxValue)

        touchDownLoacation = location
        setValue(newValue, animated: false)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        isTouchDown = false
        layoutThumbLayer(for: layer.bounds)
    }

    // MARK: - Layout Helper

    final func getTrackPath(for bounds: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let start = CGPoint(x: 0, y: bounds.midY)
        let end = CGPoint(x: bounds.maxX, y: bounds.midY)
        path.move(to: start)
        path.addLine(to: end)
        path.addClip()
        return path
    }

    final func getTickPath(for bounds: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let tickHeight = bounds.height * trackHeightScale * 2
        let start = CGPoint(x: 0, y: bounds.midY - tickHeight / 2)
        let end = CGPoint(x: 0, y: bounds.midY + tickHeight / 2)
        path.move(to: start)
        path.addLine(to: end)
        path.addClip()
        return path
    }

    final func getThumbSize() -> CGSize {
        let height = bounds.height - 2 * thumbRadiusPadding
        return CGSize(width: height, height: height)
    }

    final func getThumbOrigin(for width: CGFloat) -> CGPoint {
        let inset = thumbRadiusPadding
        let x = positionForValue(value: value)
        return CGPoint(x: x, y: inset)
    }

    final func getThumbPath(for size: CGSize) -> UIBezierPath {
        let anchorPoint = CGPoint(x: size.width / 2, y: size.height / 2)
        return UIBezierPath(arcCenter: anchorPoint, radius: size.width / 2, startAngle: .pi, endAngle: 3 * .pi, clockwise: true)
    }

    final func positionForValue(value: Double) -> CGFloat {
        let thumbWidth = getThumbSize().width
        return (bounds.width)
            * CGFloat(value - minValue)
            / CGFloat(maxValue - minValue)
            - thumbWidth / 2
    }
}
