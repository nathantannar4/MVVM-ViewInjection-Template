//
//  CustomStringConvertible+Extensions.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on 3/11/18.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension CustomStringConvertible {

    var description: String {
        return deepDescription(any: self)
    }

    // Pretty print object properties and memory info
    private func deepDescription(any: Any) -> String {
        guard let any = deepUnwrap(any: any) else {
            return "nil"
        }

        if any is Void {
            return "Void"
        }

        if let int = any as? Int {
            return String(int)
        } else if let double = any as? Double {
            return String(double)
        } else if let float = any as? Float {
            return String(float)
        } else if let bool = any as? Bool {
            return String(bool)
        } else if let string = any as? String {
            return "\"\(string)\""
        }

        func indentedString(_ value: String) -> String {
            return value.components(separatedBy: .newlines).map {
                $0.isEmpty ? "" : "\r    \($0)"
                }.joined()
        }

        let mirror = Mirror(reflecting: any)

        let properties = Array(mirror.children)

        guard let displayStyle = mirror.displayStyle else {
            return ""
        }

        switch displayStyle {
        case .tuple:
            if properties.count == 0 { return "()" }

            var string = "("

            for (index, property) in properties.enumerated() {
                if property.label?.prefix(1) == "." {
                    string += deepDescription(any: property.value)
                } else {
                    string += "\(property.label ?? "nil"): \(deepDescription(any: property.value))"
                }

                string += (index < properties.count - 1 ? ", " : "")
            }

            return string + ")"
        case .collection, .set:
            if properties.count == 0 { return "[]" }

            var string = "["

            for (index, property) in properties.enumerated() {
                string += indentedString(
                    deepDescription(any: property.value) + (index < properties.count - 1 ? ",\r" : "")
                )
            }

            return string + "\r]"
        case .dictionary:
            if properties.count == 0 { return "[:]" }

            var string = "["

            for (index, property) in properties.enumerated() {
                let pair = Array(Mirror(reflecting: property.value).children)

                let valueA = deepDescription(any: pair[0].value)
                let valueB = deepDescription(any: pair[1].value)
                string += indentedString(
                    "\(valueA): \(valueB)" + (index < properties.count - 1 ? ",\r" : "")
                )
            }
            return string + "\r]"
        case .enum:
            if let any = any as? CustomDebugStringConvertible {
                return any.debugDescription
            }

            if properties.count == 0 {
                return "\(mirror.subjectType)."
            }

            var string = "\(mirror.subjectType).\(properties.first?.label ?? "nil")"

            let associatedValueString = deepDescription(any: properties.first?.value ?? "nil")

            if associatedValueString.prefix(1) == "(" {
                string += associatedValueString
            } else {
                string += "(\(associatedValueString))"
            }
            return string
        case .struct, .class:
            if let any = any as? CustomDebugStringConvertible {
                return any.debugDescription
            }

            if properties.count == 0 {
                return ""
            }

            var string = "<\(mirror.subjectType)"

            if displayStyle == .class {
                string += ": \(Unmanaged<AnyObject>.passUnretained(any as AnyObject).toOpaque())"
            }

            string += "> {"

            for (index, property) in properties.enumerated() {
                let value = deepDescription(any: property.value)
                string += indentedString(
                    "\(property.label!): \(value)" + (index < properties.count - 1 ? ",\r" : "")
                )
            }
            return string + "\r}"
        case .optional:
            fatalError("deepUnwrap must have failed...")
        }
    }

    private func deepUnwrap(any: Any) -> Any? {
        let mirror = Mirror(reflecting: any)
        if mirror.displayStyle != .optional {
            return any
        }
        if let child = mirror.children.first, child.label == "Some" {
            return deepUnwrap(any: child.value)
        }
        return nil
    }
}

