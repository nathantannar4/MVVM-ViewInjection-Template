//
//  EditProfileView.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EditProfileView: ListView {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRows()
    }

    private func loadRows() {

        let header = SectionHeaderView<UILabel, Button>()
        header.leftView.text = "Header"
        header.rightView.setTitle("Action", for: .normal)

        let firstNameRow = TextFieldCell()
        firstNameRow.label.text = "First Name"
        firstNameRow.textField.placeholder = "First Name"

        let lastNameRow = TextFieldCell()
        lastNameRow.label.text = "Last Name"
        lastNameRow.textField.placeholder = "Last Name"

        let bioRow = TextViewCell()
        bioRow.label.text = "Bio"
        bioRow.anchor(heightConstant: 120)

        let cityRow = DetailCell<DisclosureIndicator>()
        cityRow.label.text = "City"

        let notificationsRow = SwitchCell()
        notificationsRow.label.text = "Notifications"
        notificationsRow.detailLabel.textAlignment = .right
        notificationsRow.detailLabel.text = "Detail"

        let footer = SectionFooterView<UILabel>()
        footer.centerView.numberOfLines = 0
        footer.centerView.text = "Footer"

        appendRows(header, firstNameRow, lastNameRow, bioRow, cityRow, notificationsRow, footer)
    }
}
