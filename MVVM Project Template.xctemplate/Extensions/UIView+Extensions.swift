//
//  UIView+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UIView {
    
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
        
        self.addConstraint(aspectRatioConstraint)
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
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        guard superview != nil else {
            print("💥 Could not constraints for \(self), did you add it to the view?")
            return []
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: topConstant)
            constraint.identifier = "top"
            anchors.append(constraint)
        }
        
        if let left = left {
            let constraint = leftAnchor.constraint(equalTo: left, constant: leftConstant)
            constraint.identifier = "left"
            anchors.append(constraint)
        }

        if let leading = leading {
            let constraint = leadingAnchor.constraint(equalTo: leading, constant: leftConstant)
            constraint.identifier = "leading"
            anchors.append(constraint)
        }
        
        if let bottom = bottom {
            let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
            constraint.identifier = "bottom"
            anchors.append(constraint)
        }
        
        if let right = right {
            let constraint = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
            constraint.identifier = "right"
            anchors.append(constraint)
        }

        if let trailing = trailing {
            let constraint = trailing.constraint(equalTo: trailing, constant: -rightConstant)
            constraint.identifier = "trailing"
            anchors.append(constraint)
        }
        
        if widthConstant > 0 {
            let constraint = widthAnchor.constraint(equalToConstant: widthConstant)
            constraint.identifier = "width"
            anchors.append(constraint)
        }
        
        if heightConstant > 0 {
            let constraint = heightAnchor.constraint(equalToConstant: heightConstant)
            constraint.identifier = "height"
            anchors.append(constraint)
        }
        
        NSLayoutConstraint.activate(anchors)
        return anchors
    }
    
    @discardableResult
    func anchorAbove(_ view: UIView, top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        return anchor(topAnchor, left: view.leftAnchor, bottom: view.topAnchor, right: view.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: 0, heightConstant: heightConstant)
    }
    
    @discardableResult
    func anchorBelow(_ view: UIView, bottom: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        return anchor(view.bottomAnchor, left: view.leftAnchor, bottom: bottom, right: view.rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: 0, heightConstant: heightConstant)
    }
    
    @discardableResult
    func anchorLeftOf(_ view: UIView, left: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        return anchor(view.topAnchor, left: left, bottom: view.bottomAnchor, right: view.leftAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: 0)
    }
    
    @discardableResult
    func anchorRightOf(_ view: UIView, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        return anchor(view.topAnchor, left: view.rightAnchor, bottom: view.bottomAnchor, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: 0)
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
    
    func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        let constraints = self.constraints.filter { $0.identifier == identifier }
        return constraints.first
    }
    
    func anchorWidthToItem(_ item: UIView, multiplier: CGFloat = 1) {
        let widthConstraint = widthAnchor.constraint(equalTo: item.widthAnchor, multiplier: multiplier)
        widthConstraint.isActive = true
    }
    
    func anchorHeightToItem(_ item: UIView, multiplier: CGFloat = 1) {
        let widthConstraint = heightAnchor.constraint(equalTo: item.heightAnchor, multiplier: multiplier)
        widthConstraint.isActive = true
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

    func addBorder(to side: UIRectEdge, color: UIColor, thickness: CGFloat = 1) {
        let border = BorderLayer(side: side, thickness: thickness)
        border.backgroundColor = color.cgColor
        border.name = String(describing: BorderLayer.self)
        layer.addSublayer(border)
        border.layoutSublayers()
    }

    func removeBorders() {
        self.layer.sublayers?.forEach {
            guard let name = $0.name else {
                return
            }

            if name == String(describing: BorderLayer.self) {
                $0.removeFromSuperlayer()
            }
        }
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

final class BorderLayer: CALayer {
    let side: UIRectEdge
    let thickness: CGFloat
    init(side: UIRectEdge, thickness: CGFloat) {
        self.side = side
        self.thickness = thickness
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSublayers() {
        super.layoutSublayers()
        guard let superlayer = superlayer else {
            return
        }
        switch side {
        case .left, .all:
            frame = CGRect(
                x: 0,
                y: 0,
                width: thickness,
                height: superlayer.bounds.height
            )
            fallthrough
        case .right, .all:
            frame = CGRect(
                x: superlayer.bounds.width - thickness,
                y: 0,
                width: thickness,
                height: superlayer.bounds.height
            )
        case .top, .all:
            frame = CGRect(
                x: 0,
                y: 0,
                width: superlayer.bounds.width,
                height: thickness
            )
            fallthrough
        case .bottom, .all:
            frame = CGRect(
                x: 0,
                y: superlayer.bounds.height - thickness,
                width: superlayer.bounds.width,
                height: thickness
            )
        default:
            break
        }
    }
}
