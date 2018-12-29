//
//  BadgeBarButtonItem.swift
//  FormApp
//
//  Created by Nathan Tannar on 2018-10-19.
//  Copyright © 2018 FORM. All rights reserved.
//

import UIKit

final class BadgeBarButtonItem: UIBarButtonItem {
    enum Position {
        case left, right
    }

    var badgePosition: Position = .right {
        didSet {
            setBadge(text: badgeValue)
        }
    }

    var badgeValue: String? = nil {
        didSet {
            setBadge(text: badgeValue)
        }
    }

    private var badgeLayer: CALayer?

    convenience init(title: String?, target: Any?, action: Selector?) {
        let button = UIButton(frame:
            CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        )
        if let selector = action {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(
            UIColor.black.withAlphaComponent(0.3),
            for: .highlighted
        )
        self.init(customView: button)
    }

    convenience init(image: UIImage?, target: Any?, action: Selector?) {
        let button = UIButton(frame:
            CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
        )
        if let selector = action {
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
        button.imageView?.tintColor = UIColor.black
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        self.init(customView: button)
    }

    private func setBadge(text: String?) {
        badgeLayer?.removeFromSuperlayer()
        guard let text = text else {
            return
        }
        addBadge(text: text)
    }

    private func addBadge(text: String) {

        guard let view = customView else { return }

        let size = text.isEmpty ? 8 : UIFont.smallSystemFontSize
        let font = UIFont.systemFont(ofSize: size)
        let badgeSize = text.size(withAttributes: [.font: font])

        let badge = CAShapeLayer()

        let height = badgeSize.height
        var width = badgeSize.width + 8

        if width < height {
            width = height
        }

        let mid = view.frame.midX
        let adjustment = (width / 3) * (badgePosition == .right ? 1 : -1)
        let x = mid + adjustment - (badgePosition == .right ? 0 : width)

        let badgeFrame = CGRect(
            origin: CGPoint(x: x, y: 0),
            size: CGSize(width: width, height: height)
        )

        let color = UIColor.red
        badge.fillColor = color.cgColor
        badge.strokeColor = color.cgColor
        let radius = height / 2
        badge.path = UIBezierPath(roundedRect: badgeFrame, cornerRadius: radius).cgPath

        let labelLayer = CATextLayer()
        labelLayer.string = text
        labelLayer.alignmentMode = .center
        labelLayer.font = font
        labelLayer.fontSize = font.pointSize
        labelLayer.frame = badgeFrame
        labelLayer.backgroundColor = UIColor.clear.cgColor
        labelLayer.contentsScale = UIScreen.main.scale
        badge.addSublayer(labelLayer)
        view.layer.addSublayer(badge)
        badgeLayer = badge
    }
}
