//
//  ListController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import IGListKit

class ListController<ViewModelType: IListViewModel>: ViewModelController<ViewModelType, ViewWrapped<ListView>> {

    // MARK: - Properties

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = rootView.wrappedView
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        adapter.dataSource = viewModel
        viewModel.bindToAdapter(adapter).disposed(by: disposeBag)
    }
}
