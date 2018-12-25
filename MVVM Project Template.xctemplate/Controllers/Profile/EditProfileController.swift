//
//  EditProfileController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EditProfileController: ViewModelController<EditProfileViewModel, EditProfileView> {

    private lazy var saveItem = UIBarButtonItem(title: .localize(.save), style: .plain, target: self, action: #selector(didTapSave))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = saveItem
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        viewModel.isSaving.map { !$0 }.bind(to: saveItem.rx.isEnabled).disposed(by: disposeBag)
    }

    @objc
    private func didTapSave() {
        viewModel.saveChanges()
    }
}
