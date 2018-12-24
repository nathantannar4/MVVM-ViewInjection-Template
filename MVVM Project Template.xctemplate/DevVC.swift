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

private typealias InputRow = RowView<UILabel, UILabel, DisclosureIndicator>
private typealias CheckboxRow = RowView<UILabel, UITextField, Checkbox>
private typealias SwitchRow = RowView<UILabel, UIView, Switch>
private typealias Cell = CollectionViewCell
private typealias InputCell = Cell<InputRow>
private typealias CheckboxCell = Cell<CheckboxRow>
private typealias SwitchCell = Cell<SwitchRow>

final class DevVC: Controller<CollectionView>, UICollectionViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.dataSource = self
        rootView.flowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: 44)

        rootView.registerCellClass(InputCell.self)
        rootView.registerCellClass(CheckboxCell.self)
        rootView.registerCellClass(SwitchCell.self)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let remainder = indexPath.item.remainderReportingOverflow(dividingBy: 4).partialValue

        switch remainder {
        case 3:
            let cell = collectionView.dequeueReusableCell(CheckboxCell.self, for: indexPath)
            cell.wrappedView.leftView.text = "Label"
            cell.wrappedView.rightView.placeholder = "Placeholder"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(SwitchCell.self, for: indexPath)
            cell.wrappedView.leftView.text = "Label"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(InputCell.self, for: indexPath)
            cell.wrappedView.leftView.text = "Label"
            cell.wrappedView.rightView.text = "Label"
            return cell
        }
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
