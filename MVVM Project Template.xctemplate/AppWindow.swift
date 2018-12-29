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

    var isActivityIndicatorVisible: Bool = false {
        didSet {
            isActivityIndicatorVisibleDidChange()
        }
    }

    // MARK: - Views

    private lazy var blurView = UIVisualEffectView(style: Stylesheet.VisualEffectView.regular)

    private lazy var activityIndicator: ActivitySpinnerIndicator = {
        let view = ActivitySpinnerIndicator()
        view.tintColor = .lightGray
        view.spinnerInset = UIEdgeInsets(all: 8)
        view.backgroundColor = UIColor.offWhiteColor
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 16
        view.layer.addShadow(color: UIColor.lightGrayColor)
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        backgroundColor = .white
    }

    // MARK: - Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        if isActivityIndicatorVisible {
            activityIndicator.startAnimating()
            bringSubviewToFront(activityIndicator)
        }
        if isPrivacyBlurEnabled {
            bringSubviewToFront(blurView)
            blurView.frame = bounds
        }
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

    private func isActivityIndicatorVisibleDidChange() {
        if isActivityIndicatorVisible {
            activityIndicator.alpha = 0
            addSubview(activityIndicator)
            activityIndicator.anchorCenterToSuperview()
            activityIndicator.anchor(to: CGSize(width: 80, height: 80))
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.activityIndicator.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.activityIndicator.alpha = 0
            }) { [weak self] _ in
                self?.activityIndicator.removeFromSuperview()
            }
        }
    }
}
