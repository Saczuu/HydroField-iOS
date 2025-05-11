//
//  WifiConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 08/04/2025.
//

import SwiftUI

struct WifiConnectionView: View {
    @Binding var path: [Route]
    
    @State var wifiConnectionList: [WifiConnection] = [
        .init(ssid: "YoursNetwork", strenghtLevel: 3, protedted: true),
        .init(ssid: "UnprotectedNetwork", strenghtLevel: 2, protedted: false),
        .init(ssid: "WeakNetwork", strenghtLevel: 1, protedted: false)
    ]
    
    // MARK: - Body View
    var body: some View {
        VStack {
            Spacer()
            createConnectionList()
            // Add your Wi-Fi logic
        }
    }
    
    // MARK: - Methods
    
    private func createConnectionList() -> some View {
        ScrollView {
            ForEach(wifiConnectionList) { connection in
                createConnectionCell(for: connection)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func createConnectionCell(for connection: WifiConnection) -> some View {
        CustomListCell {
            HStack {
                Text(connection.ssid)
                if connection.protedted {
                    Image(systemName: "lock")
                }
                Spacer()
                
            }
        }
    }
}

#Preview {
    WifiConnectionView(path: .constant([]))
}

struct CustomListCell<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color(.black).opacity(0.05), radius: 2, x: 0, y: 1)
            )
            .padding(.horizontal)
            .padding(.vertical, 4)
    }
}
