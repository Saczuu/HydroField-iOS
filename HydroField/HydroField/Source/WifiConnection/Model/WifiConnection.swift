//
//  WifiConnection.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/05/2025.
//

import Foundation

struct WifiConnection: Identifiable, Codable {
    var id: UUID = .init()
    var ssid: String
    var strenghtLevel: UInt8
    var protedted: Bool
}
