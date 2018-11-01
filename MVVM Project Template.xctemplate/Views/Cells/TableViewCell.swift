//
//  TableViewCellWrapped.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class TableViewCell<ViewType: IReusableView>: UITableViewCell {

    let wrappedView: ViewType!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        wrappedView = ViewType()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        wrappedView = ViewType()
        super.init(coder: aDecoder)
        cellDidLoad()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        wrappedView.prepareForReuse()
    }

    func cellDidLoad() {
        contentView.addSubview(wrappedView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        wrappedView.frame = contentView.bounds
    }

}
