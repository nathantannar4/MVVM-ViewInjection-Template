//
//  Controller.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

typealias Controller<RootViewType: IView> = BaseController<RootViewType> & IViewController

class BaseController<RootViewType: IView>: UIViewController {

    typealias IViewType = RootViewType

    // MARK: - Properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let color = rootView.backgroundColor else {
            return .default
        }
        return color.isDark ? .lightContent : .default
    }

    override var title: String? {
        didSet {
            setTitleView()
        }
    }

    var subtitle: String? {
        didSet {
            setTitleView()
        }
    }

    // MARK: - Views

    var rootView: RootViewType! {
        return view as? RootViewType
    }

    // MARK: - View Life Cycle

    override func loadView() {
        view = RootViewType(frame: UIScreen.main.bounds)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        rootView.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rootView.viewDidDisappear(animated)
    }

    // MARK: - Methods

    func setTitleView() {

        let backgroundColor = navigationController?.navigationBar.barTintColor
        let baseColor: UIColor = (backgroundColor?.isLight ?? true) ? .black : .white

        let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = baseColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.textColor = baseColor.isDark ? UIColor.darkGray : baseColor.darker()
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        subtitleLabel.text = subtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.sizeToFit()

        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        titleView.addSubview(titleLabel)
        if subtitle != nil {
            titleView.addSubview(subtitleLabel)
        } else {
            titleLabel.frame = titleView.frame
        }
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }

        navigationItem.titleView = titleView
    }
}
