//
//  JSONError.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum JSONError: Error {
    case decodingFailed
    case serializationFailed
    
    var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return "Response did not match decodable type"
        case .serializationFailed:
            return "Response was not a valid JSON object"
        }
    }
}
