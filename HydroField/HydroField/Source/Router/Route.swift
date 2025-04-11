//
//  Route.swift
//  HydroField
//
//  Created by Maciej Sączewski on 08/04/2025.
//

/// Enum representing different navigation routes in the app.
/// Each case corresponds to a screen or step in the configuration flow.
enum Route: Hashable {

    // MARK: - Cases

    /// The setup screen where the user begins the configuration process.
    case setup

    /// The Bluetooth configuration screen, where the user can pair the device.
    case bluetooth

    /// The Wi-Fi configuration screen, where the user can set up the network connection.
    case wifi
}
