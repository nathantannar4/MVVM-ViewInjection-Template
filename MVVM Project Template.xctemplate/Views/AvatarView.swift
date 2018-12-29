//
//  AvatarView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AvatarView: ImageView {

    // MARK: - Properties

    var initials: String? {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    var placeholderFont: UIFont = UIFont.boldSystemFont(ofSize: 15) {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    var placeholderTextColor: UIColor = UIColor.darkGray {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    var fontMinimumScaleFactor: CGFloat = 0.5

    var adjustsFontSizeToFitWidth = true

    private var minimumFontSize: CGFloat {
        return placeholderFont.pointSize * fontMinimumScaleFactor
    }

    private var radius: CGFloat?

    // MARK: - Overridden Properties
    override var frame: CGRect {
        didSet {
            setCorner(radius: self.radius)
        }
    }

    override var bounds: CGRect {
        didSet {
            setCorner(radius: self.radius)
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }

    private func setImageFrom(initials: String?) {
        guard let initials = initials else { return }
        image = getImageFrom(initials: initials)
    }

    private func getImageFrom(initials: String) -> UIImage {
        let width = frame.width
        let height = frame.height
        if width == 0 || height == 0 { return UIImage() }
        var font = placeholderFont

        _ = UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()!

        //// Text Drawing
        let textRect = calculateTextRect(outerViewWidth: width, outerViewHeight: height)
        let initialsText = NSAttributedString(string: initials, attributes: [.font: font])
        if adjustsFontSizeToFitWidth,
            initialsText.width(considering: textRect.height) > textRect.width {
            let newFontSize = calculateFontSize(
                text: initials,
                font: font,
                width: textRect.width,
                height: textRect.height
            )
            font = placeholderFont.withSize(newFontSize)
        }

        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: placeholderTextColor,
            .paragraphStyle: textStyle
        ]

        let textTextHeight: CGFloat = initials.boundingRect(
            with: CGSize(width: textRect.width, height: CGFloat.infinity),
            options: .usesLineFragmentOrigin,
            attributes: textFontAttributes,
            context: nil
            ).height
        context.saveGState()
        context.clip(to: textRect)
        initials.draw(in:
            CGRect(
                x: textRect.minX,
                y: textRect.minY + (textRect.height - textTextHeight) / 2,
                width: textRect.width,
                height: textTextHeight),
                      withAttributes: textFontAttributes
        )
        context.restoreGState()
        guard let renderedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        return renderedImage
    }

    /**
     Recursively find the biggest size to fit the text with a given width and height
     */
    private func calculateFontSize(text: String, font: UIFont, width: CGFloat, height: CGFloat) -> CGFloat {
        let attributedText = NSAttributedString(string: text, attributes: [.font: font])
        if attributedText.width(considering: height) > width {
            let newFont = font.withSize(font.pointSize - 1)
            if newFont.pointSize > minimumFontSize {
                return font.pointSize
            } else {
                return calculateFontSize(text: text, font: newFont, width: width, height: height)
            }
        }
        return font.pointSize
    }

    /**
     Calculates the inner circle's width.
     Note: Assumes corner radius cannot be more than width/2 (this creates circle).
     */
    private func calculateTextRect(outerViewWidth: CGFloat, outerViewHeight: CGFloat) -> CGRect {
        guard outerViewWidth > 0 else {
            return CGRect.zero
        }
        let shortEdge = min(outerViewHeight, outerViewWidth)
        // Converts degree to radian degree and calculate the
        // Assumes, it is a perfect circle based on the shorter part of ellipsoid
        // calculate a rectangle
        let w = shortEdge * sin(CGFloat(45).degreesToRadians) * 2
        let h = shortEdge * cos(CGFloat(45).degreesToRadians) * 2
        let startX = (outerViewWidth - w)/2
        let startY = (outerViewHeight - h)/2
        // In case the font exactly fits to the region, put 2 pixel both left and right
        return CGRect(x: startX + 2, y: startY, width: w - 4, height: h)
    }

    // MARK: - Internal methods

    internal func prepareView() {
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        clipsToBounds = true
        setCorner(radius: nil)
        isUserInteractionEnabled = true
        backgroundColor = UIColor.lightGrayColor
    }

    func setCorner(radius: CGFloat?) {
        guard let radius = radius else {
            //if corner radius not set default to Circle
            let cornerRadius = min(frame.width, frame.height)
            layer.cornerRadius = cornerRadius/2
            return
        }
        self.radius = radius
        layer.cornerRadius = radius
    }
}

fileprivate extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
