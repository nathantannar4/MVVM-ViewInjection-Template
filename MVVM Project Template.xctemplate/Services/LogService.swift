//
//  LogService.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftyBeaver

let Log = LogService.shared

final class LogService: Service {

    static let shared = LogService()

    let logger = SwiftyBeaver.self

    private override init() {
        super.init()
    }

    override func serviceDidLoad() {
        let console = ConsoleDestination()
        let file = FileDestination()

        console.minLevel = .verbose
        file.minLevel = .warning

        logger.addDestination(console)
        logger.addDestination(file)
    }

    func moyaLog(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            Log.info(item)
        }
    }

    /// log something generally unimportant (lowest priority)
    func verbose(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        logger.custom(level: .verbose, message: message, file: file, function: function, line: line, context: context)
    }

    /// log something which help during debugging (low priority)
    func debug(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        logger.custom(level: .debug, message: message, file: file, function: function, line: line, context: context)
    }

    /// log something which you are really interested but which is not an issue or error (normal priority)
    func info(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        logger.custom(level: .info, message: message, file: file, function: function, line: line, context: context)
    }

    /// log something which may cause big trouble soon (high priority)
    func warning(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        logger.custom(level: .warning, message: message, file: file, function: function, line: line, context: context)
    }

    /// log something which will keep you awake at night (highest priority)
    func error(_ message: @autoclosure () -> Any, _
        file: String = #file, _ function: String = #function, line: Int = #line, context: Any? = nil) {
        logger.custom(level: .error, message: message, file: file, function: function, line: line, context: context)
    }
    
}
