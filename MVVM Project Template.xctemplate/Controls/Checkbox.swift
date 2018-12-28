//
//  Checkbox.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class Checkbox: ControlElement {
    private enum KeyPath: String {
        case strokeEnd
    }

    enum Mode {
        case box, circle
    }

    enum PropertyKey: String, CaseIterable {
        case backgroundColor, borderColor, lineColor, trackColor
    }

    var isOn: Bool = false {
        didSet {
            stateDidChange()
            valueDidChange()
        }
    }

    var mode = Mode.circle {
        didSet {
            layoutSublayers(of: layer)
        }
    }

    var borderWidth: CGFloat = 2 {
        didSet {
            borderLayer.lineWidth = borderWidth
            trackLayer.lineWidth = borderWidth
        }
    }

    var lineWidth: CGFloat = 2 {
        didSet {
            pathLayer.lineWidth = lineWidth
        }
    }

    private var borderLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private var pathLayer = CAShapeLayer()

    private var properties: [ElementState:[PropertyKey:Any]] = [
        ElementState.normal: [:],
        ElementState.highlighted: [:],
        ElementState.disabled: [:],
    ]

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 25, height: 25)
    }

    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
        frame.size = intrinsicContentSize
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }

    private func controlDidLoad() {
        setBackgroundColor(.white, for: .normal)
        setLineColor(tintColor, for: .normal)
        setBorderColor(tintColor, for: .normal)
        setBorderColor(.lightGray, for: .highlighted)
        setTrackColor(.lightGray, for: .normal)
        setTrackColor(tintColor, for: .highlighted)

        addTarget(self, action: #selector(touchUp), for: .touchUpInside)

        setupBorderLayer()
        setupTrackLayer()
        setupPathLayer()

        layoutSublayers(of: layer)
    }

    private func setupBorderLayer() {
        layer.addSublayer(borderLayer)
        borderLayer.lineWidth = borderWidth
        borderLayer.lineCap = .round
        borderLayer.fillColor = nil
        borderLayer.contentsScale = UIScreen.main.scale
    }

    private func setupTrackLayer() {
        layer.addSublayer(trackLayer)
        trackLayer.lineWidth = borderWidth
        trackLayer.lineCap = .round
        trackLayer.fillColor = nil
        trackLayer.contentsScale = UIScreen.main.scale
    }

    private func setupPathLayer() {
        layer.addSublayer(pathLayer)
        pathLayer.fillColor = nil
        pathLayer.lineCap = .round
        pathLayer.lineJoin = .bevel
        pathLayer.lineWidth = lineWidth
        pathLayer.contentsScale = UIScreen.main.scale
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        borderLayer.frame = bounds
        borderLayer.path = getTrackPath().cgPath

        trackLayer.frame = bounds
        trackLayer.path = getTrackPath().cgPath

        let modeInset = mode == .circle
            ? borderLayer.frame.height / 8
            : 2 * borderWidth
        let inset = borderWidth + modeInset
        let pathInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        pathLayer.frame = bounds.inset(by: pathInset)
        pathLayer.path = getCheckPath().cgPath
    }

    func setOn(_ on: Bool, animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        isOn = on
        layoutSublayers(of: layer)
        CATransaction.commit()
    }

    func setBackgroundColor(_ color: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.backgroundColor] = color
    }

    func setBorderColor(_ color: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.borderColor] = color
    }

    func setTrackColor(_ color: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.trackColor] = color
    }

    func setLineColor(_ color: UIColor?, for state: ElementState) {
        defer { updateViewProperties() }
        properties[state]?[.lineColor] = color
    }

    override func stateDidChange() {
        super.stateDidChange()
        pathLayer.strokeEnd = isOn ? 1 : 0
        trackLayer.strokeEnd = isOn ? 1 : 0
    }

    private func updateViewProperties() {
        if let backgroundColor = properties[currentState]?[.backgroundColor] as? UIColor {
            borderLayer.fillColor = backgroundColor.cgColor
        }
        if let borderColor = properties[currentState]?[.borderColor] as? UIColor {
            borderLayer.strokeColor = borderColor.cgColor
        }
        if let trackColor = properties[currentState]?[.trackColor] as? UIColor {
            trackLayer.strokeColor = trackColor.cgColor
        }
        if let lineColor = properties[currentState]?[.lineColor] as? UIColor {
            pathLayer.strokeColor = lineColor.cgColor
        }
    }

    private func getCheckPath() -> UIBezierPath {
        let size = pathLayer.bounds.height
        let checkPath = UIBezierPath()
        checkPath.move(to: CGPoint(x: 0, y: size * 2 / 3))
        checkPath.addLine(to: CGPoint(x: size / 3, y: size))
        checkPath.addLine(to: CGPoint(x: size, y: size / 5))
        return checkPath
    }

    private func getTrackPath() -> UIBezierPath {
        switch mode {
        case .circle:
            let center = CGPoint(x: borderLayer.frame.midX, y: borderLayer.frame.midY)
            return UIBezierPath(arcCenter: center, radius: borderLayer.bounds.height / 2, startAngle: -.pi/2, endAngle: 1.5 * .pi, clockwise: true)
        case .box:
            return UIBezierPath(rect: borderLayer.bounds)
        }

    }

    @objc
    private func touchUp() {
        isOn.toggle()
    }
}
