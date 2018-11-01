//
//  ImageView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher

class ImageView: UIImageView, IView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidLoad()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewDidLoad()
    }

    func viewDidLoad() {
        contentMode = .scaleAspectFill
        kf.indicatorType = .activity
    }

    func setImage(with resource: Resource) {
        kf.setImage(with: resource)
    }
}
