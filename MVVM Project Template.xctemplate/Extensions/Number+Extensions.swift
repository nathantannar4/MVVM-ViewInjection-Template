//
//  Number+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

extension Double {
    
    func toDollars() -> String {
        return String(format: "$%.02f", self)
    }
    
    func roundTwoDecimal() -> String {
        return String(format: "%.02f", self)
    }
    
}
