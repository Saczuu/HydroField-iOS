//
//  Logger.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/04/2025.
//

import os.log
import Foundation

/// A class for logging messages with different categories and severity levels.
class Logger {
    
    /// Logs a message with a specific category and severity level.
    /// - Parameters:
    ///   - message: The message to log.
    ///   - category: The category of the log message (e.g., Bluetooth, Error, etc.).
    ///   - level: The severity level of the log (info, error, debug).
    static func log(message: String, category: LogCategory, level: OSLogType = .default) {
        // Create a custom log object based on the category
        let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: category.rawValue)
        
        // Log the message with the specified level and category
        os_log("%@", log: log, type: level, message)
    }

    /// Logs an info message with a specified category.
    /// - Parameters:
    ///   - message: The info message to log.
    ///   - category: The category of the log message (e.g., Bluetooth).
    static func info(message: String, category: LogCategory) {
        log(message: message, category: category, level: .info)
    }

    /// Logs an error message with a specified category.
    /// - Parameters:
    ///   - message: The error message to log.
    ///   - category: The category of the log message (e.g., Bluetooth).
    static func error(message: String, category: LogCategory) {
        log(message: message, category: category, level: .error)
    }

    /// Logs a debug message with a specified category.
    /// - Parameters:
    ///   - message: The debug message to log.
    ///   - category: The category of the log message (e.g., Bluetooth).
    static func debug(message: String, category: LogCategory) {
        log(message: message, category: category, level: .debug)
    }
}
