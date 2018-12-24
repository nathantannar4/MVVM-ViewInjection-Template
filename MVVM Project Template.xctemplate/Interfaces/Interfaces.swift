//
//  Interfaces.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift
import Swinject

protocol Class: AnyObject { }

protocol Interface: CustomStringConvertible { }

protocol IManager: Interface {
    func managerDidLoad()
}

protocol IService: Interface {
    func serviceDidLoad()
}

protocol IViewModel: Interface {
    func viewModelDidLoad()
}

protocol IListViewModel: IViewModel, ListAdapterDataSource {
    associatedtype Element: ListDiffable
    var elements: BehaviorSubject<[Element]> { get }
    func bindToAdapter(_ adapter: ListAdapter) -> Disposable
}

protocol IThemeable: Interface, Class {
    func themeDidChange(_ theme: Theme)
}

protocol IReusableView: Interface, Class where Self: UIView {
    func prepareForReuse()
}

protocol IReuseIdentifiable: Interface, Class {
    static var reuseIdentifier: String { get }
}

protocol IView: IThemeable where Self: UIView {
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
}

protocol IContainerView: IView {
    func applyConstraints()
}

protocol IWrapperView: Interface, Class where Self: UIView {
    associatedtype ViewType: UIView
    var wrappedView: ViewType { get }
}

protocol IViewController: Interface, Class where Self: UIViewController {
    associatedtype IViewType: IView
    var rootView: IViewType! { get }
}

protocol IViewModelViewController: IViewController {
    associatedtype IViewModelType: IViewModel
    var viewModel: IViewModelType! { get set }
    func bindToViewModel()
}

protocol IError: Interface, Error {
    var title: String?  { get set }
    var body: String? { get set }
}

protocol IPresenter: Interface where Self: UIViewController { }

protocol IErrorPresenter: IPresenter {
    func presentError(_ error: IError, animated: Bool, completion: (() -> Void)?)
}

protocol IRoutePresenter: IPresenter {
    func navigate(to route: Route, animated: Bool, completion: (() -> Void)?)
}
