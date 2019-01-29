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
        title = String.randomOfLength(10)
        view.backgroundColor = UIColor.random()

        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Next", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(next_), for: .touchUpInside)

        let bttn = UIButton()
        view.addSubview(bttn)
        bttn.setTitle("Back", for: .normal)
        bttn.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        bttn.addTarget(self, action: #selector(back_), for: .touchUpInside)

        let buttn = UIButton()
        view.addSubview(buttn)
        buttn.setTitle("Push", for: .normal)
        buttn.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        buttn.addTarget(self, action: #selector(push_), for: .touchUpInside)
    }

    @objc func next_() {
        present(DevVC(), animated: true, completion: nil)
    }

    @objc func back_() {
        dismiss(animated: true, completion: nil)
    }

    @objc func push_() {
        navigationController?.pushViewController(DevVC(), animated: true)
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
