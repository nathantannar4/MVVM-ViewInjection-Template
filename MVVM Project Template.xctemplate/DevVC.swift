//
//  DevVC.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

class DevVC: Controller<View> {
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar(frame: .zero)
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
    }
}

//class UserCell: CollectionViewCell<UserContentView> {
//    override func cellDidLoad() {
//        super.cellDidLoad()
////        wrappedView.imageView.anchor(to: CGSize(width: 100, height: 100))
//        wrappedView.actionButton.anchorWidthToItem(self, multiplier: 0.2)
//    }
//}
//class UserContentView: GridContentView<UILabel, UILabel, UIImageView, UIButton> {
//    var nameLabel: UILabel { return topView }
//    var detailLabel: UILabel { return bottomView }
//    var imageView: UIImageView { return leftView }
//    var actionButton: UIButton { return rightView }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        nameLabel.text = .randomOfLength(8)
//        detailLabel.font = UIFont.preferredFont(forTextStyle: .body)
//        detailLabel.numberOfLines = 0
//        detailLabel.text = .randomOfLength(500)
//        imageView.backgroundColor = .blue
//        actionButton.backgroundColor = .red
//        actionButton.setTitle("Action", for: .normal)
//    }
//}
