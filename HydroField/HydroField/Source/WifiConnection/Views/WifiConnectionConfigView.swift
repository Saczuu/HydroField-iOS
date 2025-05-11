//
//  WifiConnectionConfigView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/05/2025.
//

import SwiftUI

struct WifiConnectionConfigView: View {
    /// A binding to the navigation path used for controlling screen transitions.
    @Binding var path: [Route]
    
    /// The selected Wi-Fi connection passed from the router.
    let connection: WifiConnection
    
    var body: some View {
        VStack {
            Text("SSID: \(connection.ssid)")
                .font(.headline)
        }
        .navigationTitle("Configure Wi-Fi")
    }
}



// MARK: - Preview

#Preview {
    WifiConnectionConfigView(path: .constant([]),
                             connection: .init(ssid: "NetworkName", strengthLevel: 1, protected: true))
}
