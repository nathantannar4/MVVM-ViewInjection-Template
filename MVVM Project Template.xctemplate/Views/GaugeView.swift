//
//  GaugeView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

private enum ScaleFactor {
    static let progressStrokeWidth: CGFloat = 15
    static let trackStrokeWidth: CGFloat = 50
    static let titleLayerFont: CGFloat = 0.23
    static let titleLayerHeight: CGFloat = 0.3
    static let iconSize: CGFloat = 0.12
    static let subtitleLayerFont: CGFloat = 0.11
    static let subtitleLayerHeight: CGFloat = 0.12
    static let detailLayerFont: CGFloat = 0.05
    static let detailLayerHeight: CGFloat = 0.15
    static let trackShadowRadius: CGFloat = 0.017
}

class GaugeView: UIView {
    private enum KeyPath: String {
        case strokeEnd, progress
    }

    var primaryColor: UIColor = .primaryColor {
        didSet {
            applyColorsToLayers()
        }
    }

    var secondaryColor: UIColor = .secondaryColor {
        didSet {
            applyColorsToLayers()
        }
    }

    var title: String? {
        didSet {
            removeTitleSubtitleSublayers()
            titleLayer.string = title
        }
    }

    var subtitle: String? {
        didSet {
            removeTitleSubtitleSublayers()
            subtitleLayer.string = subtitle
        }
    }

    var detail: String? {
        didSet {
            detailLayer.string = detail
        }
    }

    var icon: UIImage? {
        didSet {
            iconLayer.contents = getMaskedIcon()
        }
    }

    var animationDuration: TimeInterval = 0.5

    private var progress: CGFloat = 0.001
    private var iconLayer: CALayer!
    private var titleLayer: CATextLayer!
    private var subtitleLayer: CATextLayer!
    private var detailLayer: CATextLayer!
    private var trackLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    private var gradientLayer: CAGradientLayer!

    private var progressStrokeWidth: CGFloat {
        return bounds.width / ScaleFactor.progressStrokeWidth
    }
    private var trackStrokeWidth: CGFloat {
        return bounds.width / ScaleFactor.trackStrokeWidth
    }

    // MARK: - Properties

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLayers()
    }

    func setProgress(_ percent: CGFloat, animated: Bool) {
        guard animated else {
            progress = max(percent, 0.001)
            layoutLayers()
            return
        }

        let basicAnimation = CABasicAnimation(keyPath: KeyPath.strokeEnd.rawValue)
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        basicAnimation.fromValue = progress
        basicAnimation.toValue = max(percent, 0.001)
        basicAnimation.duration = animationDuration
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        progressLayer.add(basicAnimation, forKey: KeyPath.progress.rawValue)
        progress = max(percent, 0.001)
    }

    func addLayers(for formattedTime: [String], units: [String]) {
        title = nil
        subtitle = nil

        let leftTitle = createTextLayer()
        leftTitle.fontSize = titleLayer.fontSize
        leftTitle.string = formattedTime.first
        let rightTitle = createTextLayer()
        rightTitle.fontSize = titleLayer.fontSize
        rightTitle.string = formattedTime.last

        leftTitle.frame = CGRect(
            x: 0,
            y: 0,
            width: titleLayer.bounds.width / 2,
            height: titleLayer.bounds.height
        )
        rightTitle.frame = CGRect(
            x: titleLayer.bounds.width / 2,
            y: 0,
            width: titleLayer.bounds.width / 2,
            height: titleLayer.bounds.height
        )
        titleLayer.addSublayer(leftTitle)
        titleLayer.addSublayer(rightTitle)

        let leftSubtitle = createTextLayer()
        leftSubtitle.fontSize = subtitleLayer.fontSize
        leftSubtitle.string = units.first
        let rightSubtitle = createTextLayer()
        rightSubtitle.fontSize = subtitleLayer.fontSize
        rightSubtitle.string = units.last

        leftSubtitle.frame = CGRect(
            x: 0,
            y: 0,
            width: subtitleLayer.bounds.width / 2,
            height: subtitleLayer.bounds.height
        )
        rightSubtitle.frame = CGRect(
            x: subtitleLayer.bounds.width / 2,
            y: 0,
            width: subtitleLayer.bounds.width / 2,
            height: subtitleLayer.bounds.height
        )
        subtitleLayer.addSublayer(leftSubtitle)
        subtitleLayer.addSublayer(rightSubtitle)
    }

    private func removeTitleSubtitleSublayers() {
        titleLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
        subtitleLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }

    // MARK: - Setup [Private]

    private func setup() {
        backgroundColor = .clear
        setupTrackLayer()
        setupProgressLayer()
        setupContentLayers()
        applyColorsToLayers()
    }

    private func layoutLayers() {
        gradientLayer?.frame = bounds

        let contentsInset = 1.5 * progressStrokeWidth

        let titleHeight = bounds.height * ScaleFactor.titleLayerHeight
        titleLayer?.frame = CGRect(
            x: contentsInset,
            y: bounds.midY - titleHeight / 2,
            width: bounds.width - 2 * contentsInset,
            height: titleHeight
        )

        let iconSize = CGSize(
            width: bounds.width * ScaleFactor.iconSize,
            height: bounds.height * ScaleFactor.iconSize
        )
        iconLayer?.frame = CGRect(
            x: bounds.midX - iconSize.width / 2,
            y: bounds.midY - titleHeight / 2 - iconSize.height,
            width: iconSize.width,
            height: iconSize.height
        )

        let subtitleHeight = bounds.height * ScaleFactor.subtitleLayerHeight
        subtitleLayer?.frame = CGRect(
            x: contentsInset,
            y: bounds.midY + titleHeight / 3,
            width: bounds.width - 2 * contentsInset,
            height: subtitleHeight
        )

        let detailHeight = bounds.height * ScaleFactor.detailLayerHeight
        detailLayer?.frame = CGRect(
            x: contentsInset,
            y: bounds.height - detailHeight,
            width: bounds.width - 2 * contentsInset,
            height: detailHeight
        )
    }

    private func applyColorsToLayers() {
        gradientLayer.colors = [secondaryColor.cgColor, primaryColor.cgColor]

        progressLayer.addShadow(color: primaryColor)

        trackLayer.strokeColor = primaryColor.withAlphaComponent(0.3).cgColor

        [titleLayer, subtitleLayer, detailLayer].forEach {
            $0?.foregroundColor = primaryColor.cgColor
        }

        iconLayer.contents = getMaskedIcon()
    }

    private func setupProgressLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0, 1]

        progressLayer = createGaugeProgressLayer()
        progressLayer.shadowRadius = bounds.height * ScaleFactor.trackShadowRadius

        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
    }

    private func setupTrackLayer() {
        trackLayer = createGaugeTrackLayer()
        layer.addSublayer(trackLayer)
    }

    private func setupContentLayers() {
        titleLayer = createTextLayer()
        titleLayer.string = title
        titleLayer.fontSize = bounds.height * ScaleFactor.titleLayerFont
        layer.addSublayer(titleLayer)

        iconLayer = CALayer()
        iconLayer.contents = getMaskedIcon()
        iconLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(iconLayer)

        subtitleLayer = createTextLayer()
        subtitleLayer.string = subtitle
        subtitleLayer.fontSize = bounds.height * ScaleFactor.subtitleLayerFont
        layer.addSublayer(subtitleLayer)

        detailLayer = createTextLayer()
        detailLayer.string = detail
        detailLayer.fontSize = bounds.height * ScaleFactor.detailLayerFont
        layer.addSublayer(detailLayer)
    }

    private func createGaugeProgressLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = arcPath().cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = progressStrokeWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.contentsScale = UIScreen.main.scale
        layer.strokeEnd = progress
        return layer
    }

    private func createGaugeTrackLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.path = arcPath().cgPath
        layer.lineWidth = trackStrokeWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = .round
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.contentsScale = UIScreen.main.scale
        return layer
    }

    private func arcPath() -> UIBezierPath {
        let radius = bounds.width / 2 - progressStrokeWidth
        let path = UIBezierPath(
            arcCenter: .zero,
            radius: radius,
            startAngle: (.pi / 2) + (.pi / 6),
            endAngle: (.pi / 2) - (.pi / 6),
            clockwise: true
        )
        return path
    }

    private func createTextLayer() -> CATextLayer {
        let layer = CATextLayer()
        layer.alignmentMode = .center
        layer.foregroundColor = primaryColor.cgColor
        layer.contentsScale = UIScreen.main.scale
        return layer
    }

    private func getMaskedIcon() -> CGImage? {
        let mask = icon?.withRenderingMode(.alwaysTemplate)
        let colorMasked = mask?.masked(with: primaryColor)
        return colorMasked?.cgImage
    }
}
