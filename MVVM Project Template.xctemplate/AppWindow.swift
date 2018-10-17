//
//  AppWindow.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AppWindow: UIWindow {

    // MARK: - Properties

    var isPrivacyBlurEnabled: Bool = false {
        didSet {
            isPrivacyBlurEnabledDidChange()
        }
    }

    // MARK: - Views

    private let blurView = UIVisualEffectView(style: Stylesheet.VisualEffectView.regular)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .white
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        guard isPrivacyBlurEnabled else { return }
        bringSubviewToFront(blurView)
        blurView.frame = bounds
    }

    private func isPrivacyBlurEnabledDidChange() {
        if isPrivacyBlurEnabled {
            blurView.alpha = 0
            addSubview(blurView)
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.blurView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.blurView.alpha = 0
            }) { [weak self] _ in
                self?.blurView.removeFromSuperview()
            }
        }
    }

}
