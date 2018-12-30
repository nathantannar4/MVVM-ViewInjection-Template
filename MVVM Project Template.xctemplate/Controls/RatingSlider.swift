//
//  RatingSlider.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class RatingSlider: ControlElement {

    // MARK: - Properties

    var rating: Double = 4 {
        didSet {
            valueDidChange()
        }
    }

    var spacing: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }

    var isEditable: Bool = false

    var starPointyness: CGFloat {
        get { return starViews[0].pointyness }
        set { starViews.forEach { $0.pointyness = newValue } }
    }

    private let starViews = [
        StarView(), StarView(), StarView(), StarView(), StarView()
    ]

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        controlDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        controlDidLoad()
    }

    // MARK: - API

    override func valueDidChange() {
        super.valueDidChange()
        adjustColorsForValue()
    }

    // MARK: - View Life Cycle

    func controlDidLoad() {
        tintColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
        starViews.forEach { addSubview($0) }
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()
        adjustColorsForValue()
    }

    private func adjustColorsForValue() {
        for (i, view) in starViews.enumerated() {
            let isFilled = i < Int(rating.rounded())
            view.fillColor = isFilled ? tintColor.cgColor : tintColor.withAlphaComponent(0.3).cgColor
            view.borderColor = nil
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let usableWidth = bounds.width - (spacing * CGFloat(starViews.count - 1))
        let width = (usableWidth / CGFloat(starViews.count))
        var x: CGFloat = 0
        for view in starViews {
            view.frame = CGRect(x: x, y: 0, width: width, height: bounds.height)
            x += width + spacing
        }
    }

    // MARK: - Touch

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        updateLocation(touch)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        updateLocation(touch)
    }

    private func updateLocation(_ touch: UITouch) {
        guard isEditable else { return }

        let x = touch.location(in: self).x
        if x <= 0 {
            rating = 0
        } else if x > bounds.width {
            rating = Double(starViews.count)
        } else {
            let dx = Double(x / bounds.width)
            let rawRating = dx * Double(starViews.count)
            rating = (rawRating * 10).rounded() / 10
        }
    }
}

