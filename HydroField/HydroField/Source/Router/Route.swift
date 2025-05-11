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
    
    /// The Wi-Fi connection list  screen, where the user can select  the network connection for setup.
    case wifiList
    
    /// The Wi-Fi connection configuration, where user can provide password and attempt connection.
    case wifiConfig(WifiConnection)
    
    // MARK: - Equatable
    /// Compares two `Route` values for equality.
    /// - Parameters:
    ///   - lhs: The first route to compare.
    ///   - rhs: The second route to compare.
    /// - Returns: `true` if both routes are of the same case and, in the case of `.wifiConfig`, contain equal associated values.
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.setup, .setup),
             (.bluetooth, .bluetooth),
             (.wifiList, .wifiList):
            return true
        case let (.wifiConfig(lhsConn), .wifiConfig(rhsConn)):
            return lhsConn == rhsConn
        default:
            return false
        }
    }

    // MARK: - Hashale 
    /// Hashes the essential components of the `Route`.
    /// - Parameter hasher: The hasher to use when combining the components of this value.
    ///
    /// This allows `Route` to conform to `Hashable`, making it usable in sets, as dictionary keys,
    /// and in SwiftUI navigation stacks with associated values.
    func hash(into hasher: inout Hasher) {
        switch self {
        case .setup:
            hasher.combine("setup")
        case .bluetooth:
            hasher.combine("bluetooth")
        case .wifiList:
            hasher.combine("wifiList")
        case .wifiConfig(let connection):
            hasher.combine("wifiConfig")
            hasher.combine(connection) // Ensure WifiConnection conforms to Hashable
        }
    }}
