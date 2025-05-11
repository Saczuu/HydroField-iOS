//
//  WifiConnection.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/05/2025.
//

import Foundation

/// Represents a Wi-Fi connection with identifiable and serializable properties.
struct WifiConnection: Identifiable, Codable, Equatable, Hashable {
    //MARK: - Properties
    
    /// A unique identifier for the connection instance.
    var id: UUID = .init()
    
    /// The SSID (network name) of the Wi-Fi connection.
    var ssid: String
    
    /// The signal strength level of the connection, typically from 0 to 100.
    var strengthLevel: UInt8
    
    /// A Boolean value indicating whether the network is protected (e.g., password-protected).
    var protected: Bool

    // MARK: - Equatable
    
    /// Compares two `WifiConnection` instances for equality.
    /// - Parameters:
    ///   - lhs: The first `WifiConnection` to compare.
    ///   - rhs: The second `WifiConnection` to compare.
    /// - Returns: `true` if all properties are equal.
    static func == (lhs: WifiConnection, rhs: WifiConnection) -> Bool {
        return lhs.id == rhs.id &&
               lhs.ssid == rhs.ssid &&
               lhs.strengthLevel == rhs.strengthLevel &&
               lhs.protected == rhs.protected
    }
    
    // MARK: - Hashable
    
    /// Hashes the essential components of the `WifiConnection`.
    /// - Parameter hasher: The hasher to use when combining the components of this value.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(ssid)
        hasher.combine(strengthLevel)
        hasher.combine(protected)
    }
}

