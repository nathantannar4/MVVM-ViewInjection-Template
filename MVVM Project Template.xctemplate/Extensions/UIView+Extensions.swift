//
//  UIView+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ConstraintIdentifier: String, CaseIterable {
    case top, left, leading, right, trailing, bottom, width, height
}

extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    func fillSuperview(inSafeArea: Bool = false) {

        guard let superview = self.superview else {
            print("💥 Could not constraints for \(self), did you add it to the view?")
            return
        }
        translatesAutoresizingMaskIntoConstraints = false

        if inSafeArea, #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                topAnchor.constraint(equalTo: superview.topAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        }
    }
    
    func anchorAspectRatio() {
        let aspectRatioConstraint = NSLayoutConstraint(item: self,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .width,
                                                       multiplier: 1,
                                                       constant: 0)
        
        addConstraint(aspectRatioConstraint)
    }

    func anchor(to size: CGSize) {
        _ = anchor(widthConstant: size.width, heightConstant: size.height)
    }

    @discardableResult
    private func _anchor(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = -1,
        heightConstant: CGFloat = -1) -> [NSLayoutConstraint] {

        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()

        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: topConstant)
            constraint.identifier = ConstraintIdentifier.top.rawValue
            anchors.append(constraint)
        }

        if let left = left {
            let constraint = leftAnchor.constraint(equalTo: left, constant: leftConstant)
            constraint.identifier = ConstraintIdentifier.left.rawValue
            anchors.append(constraint)
        }

        if let leading = leading {
            let constraint = leadingAnchor.constraint(equalTo: leading, constant: leftConstant)
            constraint.identifier = ConstraintIdentifier.leading.rawValue
            anchors.append(constraint)
        }

        if let bottom = bottom {
            let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
            constraint.identifier = ConstraintIdentifier.bottom.rawValue
            anchors.append(constraint)
        }

        if let right = right {
            let constraint = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
            constraint.identifier = ConstraintIdentifier.right.rawValue
            anchors.append(constraint)
        }

        if let trailing = trailing {
            let constraint = trailing.constraint(equalTo: trailing, constant: -rightConstant)
            constraint.identifier = ConstraintIdentifier.trailing.rawValue
            anchors.append(constraint)
        }

        if widthConstant >= 0 {
            let constraint = widthAnchor.constraint(equalToConstant: widthConstant)
            constraint.identifier = ConstraintIdentifier.width.rawValue
            anchors.append(constraint)
        }

        if heightConstant >= 0 {
            let constraint = heightAnchor.constraint(equalToConstant: heightConstant)
            constraint.identifier = ConstraintIdentifier.height.rawValue
            anchors.append(constraint)
        }

        return anchors
    }

    @discardableResult
    func anchorIfNeeded(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = -1,
        heightConstant: CGFloat = -1) -> [NSLayoutConstraint] {

        let anchors = _anchor(top, left: left, leading: leading, bottom: bottom, right: right, trailing: trailing, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
        anchors.forEach { $0.priority = .defaultLow }
        NSLayoutConstraint.activate(anchors)
        return anchors
    }
    
    @discardableResult
    func anchor(
        _ top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = -1,
        heightConstant: CGFloat = -1) -> [NSLayoutConstraint] {

        let anchors = _anchor(top, left: left, leading: leading, bottom: bottom, right: right, trailing: trailing, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
        NSLayoutConstraint.activate(anchors)
        return anchors
    }
    
    @discardableResult
    func anchorAbove(_ view: UIView, top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, heightConstant: CGFloat = -1) -> [NSLayoutConstraint] {
        return anchor(top, left: view.leftAnchor, bottom: view.topAnchor, right: view.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: -1, heightConstant: heightConstant)
    }
    
    @discardableResult
    func anchorBelow(_ view: UIView, bottom: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, heightConstant: CGFloat = -1) -> [NSLayoutConstraint] {
        return anchor(view.bottomAnchor, left: view.leftAnchor, bottom: bottom, right: view.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: -1, heightConstant: heightConstant)
    }
    
    @discardableResult
    func anchorLeftOf(_ view: UIView, left: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = -1) -> [NSLayoutConstraint] {
        return anchor(view.topAnchor, left: left, bottom: view.bottomAnchor, right: view.leftAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: -1)
    }
    
    @discardableResult
    func anchorRightOf(_ view: UIView, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = -1) -> [NSLayoutConstraint] {
        return anchor(view.topAnchor, left: view.rightAnchor, bottom: view.bottomAnchor, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: -1)
    }
    
    func anchorCenterXToSuperview(constant: CGFloat = 0) {

        guard let superview = self.superview else {
            print("💥 Could not constraints for \(self), did you add it to the view?")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }
    
    func anchorCenterYToSuperview(constant: CGFloat = 0) {

        guard let superview = self.superview else {
            print("💥 Could not constraints for \(self), did you add it to the view?")
            return
        }

        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }
    
    func anchorCenterToSuperview() {
        anchorCenterYToSuperview()
        anchorCenterXToSuperview()
    }
    
    func constraint(for identifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        let constraints = self.constraints.filter { $0.identifier == identifier.rawValue }
        return constraints.first
    }

    @discardableResult
    func anchorWidthToItem(_ item: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let widthConstraint = widthAnchor.constraint(equalTo: item.widthAnchor, multiplier: multiplier)
        widthConstraint.identifier = ConstraintIdentifier.width.rawValue
        widthConstraint.isActive = true
        return widthConstraint
    }

    @discardableResult
    func anchorHeightToItem(_ item: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        let heightConstraint = heightAnchor.constraint(equalTo: item.heightAnchor, multiplier: multiplier)
        heightConstraint.identifier = ConstraintIdentifier.height.rawValue
        heightConstraint.isActive = true
        return heightConstraint
    }
    
    func removeAllConstraints() {
        var view: UIView? = self
        while let currentView = view {
            currentView.removeConstraints(currentView.constraints.filter {
                return $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
            })
            view = view?.superview
        }
    }

    public enum ViewSide {
        case top
        case right
        case bottom
        case left
    }

    public func addBorderLayer(to side: ViewSide, color: UIColor, thickness: CGFloat = 1) {
        switch side {
        case .top:
            let border = _getOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: frame.size.width,
                    height: thickness
            ), color: color)
            layer.addSublayer(border)
        case .right:
            let border = _getOneSidedBorder(
                frame: CGRect(
                    x: frame.size.width - thickness,
                    y: 0,
                    width: thickness,
                    height: frame.size.height
            ), color: color)
            layer.addSublayer(border)
        case .bottom:
            let border = _getOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: frame.size.height - thickness,
                    width: frame.size.width,
                    height: thickness
            ), color: color)
            layer.addSublayer(border)
        case .left:
            let border = _getOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: thickness,
                    height: frame.size.height
            ), color: color)
            layer.addSublayer(border)
        }
    }

    public func addBorderView(to side: ViewSide, color: UIColor, thickness: CGFloat = 1) {

        switch side {
        case .top:
            let border = _getViewBackedOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: frame.size.width,
                    height: thickness
            ), color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            addSubview(border)

        case .right:
            let border = _getViewBackedOneSidedBorder(frame:
                CGRect(
                    x: frame.size.width - thickness,
                    y: 0,
                    width: thickness,
                    height: frame.size.height
            ), color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
            addSubview(border)

        case .bottom:
            let border: UIView = _getViewBackedOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: frame.size.height - thickness,
                    width: frame.size.width,
                    height: thickness
            ), color: color)
            border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
            addSubview(border)
        case .left:
            let border: UIView = _getViewBackedOneSidedBorder(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: thickness,
                    height: frame.size.height
            ), color: color)
            border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
            addSubview(border)
        }
    }

    private func _getOneSidedBorder(frame: CGRect, color: UIColor) -> CALayer {
        let border = CALayer()
        border.frame = frame
        border.backgroundColor = color.cgColor
        return border
    }

    private func _getViewBackedOneSidedBorder(frame: CGRect, color: UIColor) -> UIView {
        let border = UIView(frame: frame)
        border.backgroundColor = color
        return border
    }

    @discardableResult
    func round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }

    var interfaceSubviews: [IView] {
        return subviews.compactMap { $0 as? IView }
    }

}
