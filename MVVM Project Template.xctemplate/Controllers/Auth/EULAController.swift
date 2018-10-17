//
//  EULAController.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EULAController: ViewModelController<EULAViewModel, EULAView> {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.appViewModel.appDisplayName
        subtitle = .localize(.eula)
    }

    override func bindToViewModel() {
        super.bindToViewModel()
        rootView.rx.selector.subscribe { [weak self] event in
            switch event {
            case .next(let selector):
                switch selector {
                case .didTapDone:
                    self?.dismiss(animated: true, completion: nil)
                }
            case .error, .completed:
                break
            }
        }.disposed(by: disposeBag)

        viewModel.eula.bind(to: rootView.rx.eula).disposed(by: disposeBag)
    }
}
