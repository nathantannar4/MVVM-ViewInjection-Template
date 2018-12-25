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

final class EditProfileView: FormView {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRows()
    }

    private func loadRows() {

        let firstNameRow = TextFieldRow()
        firstNameRow.label.text = "First Name"
        firstNameRow.textField.placeholder = "First Name"

        let lastNameRow = TextFieldRow()
        lastNameRow.label.text = "Last Name"
        lastNameRow.textField.placeholder = "Last Name"

        let cityRow = DetailRow<DisclosureIndicator>()
        cityRow.label.text = "City"

        let notificationsRow = SwitchRow()
        notificationsRow.label.text = "Notifications"

        appendRows(firstNameRow, lastNameRow, cityRow, notificationsRow)
    }
}
