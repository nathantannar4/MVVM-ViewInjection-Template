//
//  ActivitySpinnerIndicator.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import QuartzCore

final class ActivitySpinnerIndicator: UIView {
    private enum AnimationKey: String {
        case opacity, lineWidth, rotation, fade
        case transformRotation = "transform.rotation"
    }

    var animationDuration: Double = 1
    var rotationDuration: Double = 10

    var spinnerInset: UIEdgeInsets = .zero {
        didSet {
            layoutSubviews()
        }
    }

    var lineWidth: CGFloat = 6 {
        didSet {
            segmentLayer?.lineWidth = lineWidth
            drawSegments()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: 30 + spinnerInset.horizontal,
            height: 30 + spinnerInset.vertical
        )
    }

    private var numberOfSegments: Int {
        return 2 * Int(bounds.width - spinnerInset.horizontal)
    }

    /// A Boolean value that returns whether the indicator is animating or not.
    private(set) var isAnimating = false

    /// the layer replicating the segments.
    private weak var replicatorLayer: CAReplicatorLayer!

    /// the visual layer that gets replicated around the indicator.
    private weak var segmentLayer: CAShapeLayer!

    convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {

        let dot = CAShapeLayer()
        dot.lineCap = .round
        dot.strokeColor = tintColor.cgColor
        dot.lineWidth = 0
        dot.lineJoin = .round
        dot.fillColor = nil

        let replicatorLayer = CAReplicatorLayer()
        layer.addSublayer(replicatorLayer)
        replicatorLayer.addSublayer(dot)

        self.replicatorLayer = replicatorLayer
        self.segmentLayer = dot
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        segmentLayer?.strokeColor = tintColor.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        replicatorLayer.frame = bounds.inset(by: spinnerInset)
        replicatorLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        drawSegments()
    }

    private func drawSegments() {
        guard numberOfSegments > 0, let segmentLayer = segmentLayer else { return }

        let angle = 2 * CGFloat.pi / CGFloat(numberOfSegments)
        replicatorLayer.instanceCount = numberOfSegments
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        replicatorLayer.instanceDelay = animationDuration / Double(numberOfSegments)

        let maxRadius = min(replicatorLayer.bounds.width, replicatorLayer.bounds.height) / 2
        let radius: CGFloat = maxRadius - lineWidth / 2

        segmentLayer.bounds = CGRect(x: 0, y: 0, width: 2 * maxRadius, height: 2 * maxRadius)
        segmentLayer.position = CGPoint(x: replicatorLayer.bounds.width / 2, y: replicatorLayer.bounds.height / 2)

        let path = UIBezierPath(arcCenter: CGPoint(x: maxRadius, y: maxRadius), radius: radius, startAngle: -angle/2 - CGFloat.pi/2, endAngle: angle/2 - CGFloat.pi/2, clockwise: true)
        segmentLayer.path = path.cgPath
    }

    func startAnimating() {
        guard !isAnimating else { return }
        defer { isAnimating = true }

        let rotate = CABasicAnimation(keyPath: AnimationKey.transformRotation.rawValue)
        rotate.byValue = CGFloat.pi * 2
        rotate.duration = rotationDuration
        rotate.repeatCount = .infinity

        let opacity = CABasicAnimation(keyPath: AnimationKey.opacity.rawValue)
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.duration = animationDuration
        opacity.repeatCount = .infinity
        opacity.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        let fade = CABasicAnimation(keyPath: AnimationKey.lineWidth.rawValue)
        fade.fromValue = lineWidth
        fade.toValue = 0
        fade.duration = animationDuration
        fade.repeatCount = .infinity
        fade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        replicatorLayer.add(rotate, forKey: AnimationKey.rotation.rawValue)
        segmentLayer.add(opacity, forKey: AnimationKey.opacity.rawValue)
        segmentLayer.add(fade, forKey: AnimationKey.fade.rawValue)
    }

    func stopAnimating() {
        guard isAnimating else { return }
        defer { isAnimating = false }

        replicatorLayer.removeAnimation(forKey: AnimationKey.rotation.rawValue)
        segmentLayer.removeAnimation(forKey: AnimationKey.opacity.rawValue)
        segmentLayer.removeAnimation(forKey: AnimationKey.fade.rawValue)
    }
}
