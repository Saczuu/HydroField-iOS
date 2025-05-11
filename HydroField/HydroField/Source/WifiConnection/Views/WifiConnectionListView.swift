//
//  WifiConnectionListView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 08/04/2025.
//

import SwiftUI

struct WifiConnectionListView: View {
    // MARK: - Properties
    
    @Binding var path: [Route]
    
    @State var wifiConnectionList: [WifiConnection] = [
         .init(ssid: "YoursNetwork", strengthLevel: 3, protected: true),
         .init(ssid: "UnprotectedNetwork", strengthLevel: 2, protected: false),
         .init(ssid: "WeakNetwork", strengthLevel: 1, protected: false)
        ]
    
    // MARK: - Body View
    
    var body: some View {
        VStack {
            Spacer()
            createConnectionList()
        }
        .navigationTitle("Select Wi-Fi")
    }
    
    // MARK: - Methods
    
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
        Button {
            self.path.append(.wifiConfig(connection))
        } label: {
            WifiConnectionCell {
                HStack {
                    Text(connection.ssid)
                    Spacer()
                    if connection.protected {
                        Image(systemName: "lock")
                    }
                    createStrengthLevelIndicator(connection.strengthLevel)
                }
            }
        }
        .buttonStyle(.plain)
            
    }
    
    private func createStrengthLevelIndicator(_ strengthLevel: UInt8) -> some View {
        Image("hydrofield.wifi.\(strengthLevel)")
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        WifiConnectionListView(path: .constant([]))
    }
}
