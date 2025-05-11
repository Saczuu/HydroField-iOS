//
//  WifiConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 08/04/2025.
//

import SwiftUI

struct WifiConnectionView: View {
    // MARK: - Properties
    
    @Binding var path: [Route]
    
    @State var wifiConnectionList: [WifiConnection] = [
        .init(ssid: "YoursNetwork", strenghtLevel: 3, protedted: true),
        .init(ssid: "UnprotectedNetwork", strenghtLevel: 2, protedted: false),
        .init(ssid: "WeakNetwork", strenghtLevel: 1, protedted: false)
    ]
    
    // MARK: - Body View
    
    var body: some View {
        VStack {
            createLabel()
            Spacer()
            createConnectionList()
            // Add your Wi-Fi logic
        }
    }
    
    // MARK: - Methods
    
    private func createLabel() -> some View {
        Text("Select network to connect")
            .padding()
    }
    
    private func createConnectionList() -> some View {
        ScrollView {
            ForEach(wifiConnectionList) { connection in
                createConnectionCell(for: connection)
            }
        }
        .padding()
        .scaledToFit()
    }
    
    @ViewBuilder
    private func createConnectionCell(for connection: WifiConnection) -> some View {
        WifiConnectionCell {
            HStack {
                Text(connection.ssid)
                if connection.protedted {
                    Image(systemName: "lock")
                }
                Spacer()
                createStrenghLevelIndicator(connection.strenghtLevel)
                
            }
        }
    }
    
    private func createStrenghLevelIndicator(_ strenght: UInt8) -> some View {
        Image("hydrofield.wifi.\(strenght)")
    }
}

// MARK: - Preview

#Preview {
    WifiConnectionView(path: .constant([]))
}
