//
//  RxSwift+Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on 3/11/18.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - BiDirectional Binding

infix operator <->

func <-> <T: Comparable>(property: ControlProperty<T>, subject: BehaviorSubject<T>) -> Disposable {
    let subjectToProperty = subject.asObservable()
        .distinctUntilChanged()
        .bind(to: property)

    let propertyToVariable = property
        .distinctUntilChanged()
        .bind(to: subject)

    return CompositeDisposable(subjectToProperty, propertyToVariable)
}

func <-> <T: Comparable>(subject: BehaviorSubject<T>, property: ControlProperty<T>) -> Disposable {
    let propertyToVariable = property
        .distinctUntilChanged()
        .bind(to: subject)

    let subjectToProperty = subject.asObservable()
        .distinctUntilChanged()
        .bind(to: property)

    return CompositeDisposable(propertyToVariable, subjectToProperty)
}

func <-> <T: Comparable>(left: BehaviorSubject<T>, right: BehaviorSubject<T>) -> Disposable {
    let leftToRight = left.distinctUntilChanged().bind(to: right)
    let rightToLeft = right.distinctUntilChanged().bind(to: left)
    return CompositeDisposable(leftToRight, rightToLeft)
}

extension Optional: Comparable where Wrapped: Equatable {
    public static func < (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let lhsValue), .some(let rhsValue)):
            return lhsValue < rhsValue
        default:
            return false
        }
    }

    public static func <= (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let lhsValue), .some(let rhsValue)):
            return lhsValue <= rhsValue
        default:
            return false
        }
    }

    public static func > (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let lhsValue), .some(let rhsValue)):
            return lhsValue > rhsValue
        default:
            return false
        }
    }

    public static func >= (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Bool {
        switch (lhs, rhs) {
        case (.some(let lhsValue), .some(let rhsValue)):
            return lhsValue >= rhsValue
        default:
            return false
        }
    }
}

// MARK: - BehaviorSubject

extension BehaviorSubject {
    var value: Element? {
        return try? value()
    }
}
