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

class DevVC: Controller<CollectionView>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.dataSource = self
//        rootView.delegate = self

        rootView.registerCellClass(
            CollectionViewCell<TextFieldCell>.self
        )

//        rootView.transform = CGAffineTransform(rotationAngle: -.pi)
        rootView.refreshControl = UIRefreshControl()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(CollectionViewCell<TextFieldCell>.self, for: indexPath)
        cell.wrappedView.label.text = "\(indexPath)"
        cell.wrappedView.backgroundColor = indexPath.row % 2 == 0 ? .lightGrayColor : .white
//        cell.contentView.transform = CGAffineTransform(rotationAngle: .pi)
        return cell
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
