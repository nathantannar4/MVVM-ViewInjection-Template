//
//  Reflectable.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//


import Foundation

protocol Reflectable {
    func asJSON() -> Any?
}

protocol RawValueReflectable: Reflectable { }

extension Reflectable {
    func asJSON() -> Any? {
        let mirror = Mirror(reflecting: self)
        guard mirror.children.count > 0 else { return self }
        var out: [String: Any] = [:]
        for case let (key?, value) in mirror.children {
            if let value = value as? Reflectable {
                out[key] = value.asJSON()
            }
        }
        return out
    }
}

extension String: Reflectable {}
extension Int: Reflectable {}
extension Float: Reflectable {}
extension Double: Reflectable {}
extension Bool: Reflectable {}

extension Array: Reflectable where Element: Reflectable {
    func asJSON() -> Any? {
        return compactMap { $0.asJSON() }
    }
}

extension Optional: Reflectable where Wrapped: Reflectable {
    func asJSON() -> Any? {
        switch self {
        case .some(let value):
            return value.asJSON()
        case .none:
            return nil
        }
    }
}

extension Dictionary: Reflectable where Key == String, Value: Reflectable  {
    func asJSON() -> Any? {
        return mapValues { $0.asJSON() ?? $0 }
    }
}

extension RawValueReflectable where Self: RawRepresentable, Self.RawValue: Reflectable {
    func asJSON() -> Any? {
        return rawValue
    }
}
