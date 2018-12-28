//
//  CollectionController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import IGListKit

class CollectionController<ViewModelType: IListViewModel>: ViewModelController<ViewModelType, CollectionView> {

    // MARK: - Properties

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    var collectionView: CollectionView {
        return rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = rootView
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        adapter.dataSource = viewModel
        viewModel.bindToAdapter(adapter).disposed(by: disposeBag)
    }
}
