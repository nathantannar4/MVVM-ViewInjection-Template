//
//  Rows.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TextFieldRow: RowView<UILabel, TextField, UIView> {
    var label: UILabel { return leftView }
    var textField: TextField { return rightView }
}

class DetailRow<AccessoryViewType: UIView>: RowView<UILabel, UILabel, AccessoryViewType> {
    var label: UILabel { return leftView }
    var detailLabel: UILabel { return rightView }
}

class CheckboxRow: RowView<UILabel, UIView, Checkbox> {
    var label: UILabel { return leftView }
    var checkbox: Checkbox { return accessoryView }
}

class SwitchRow: RowView<UILabel, UIView, Switch> {
    var label: UILabel { return leftView }
    var `switch`: Switch { return accessoryView }
}
