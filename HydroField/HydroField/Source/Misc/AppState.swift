//
//  AppState.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/04/2025.
//

/// Enum representing the different states of the app configuration process.
/// This enum tracks whether the app has been configured or not.
enum AppState: String {

    // MARK: - Cases

    /// The app is in an unconfigured state, and setup has not been completed yet.
    case unconfigured

    /// The app has been successfully configured and is ready for further use.
    case configured
}
