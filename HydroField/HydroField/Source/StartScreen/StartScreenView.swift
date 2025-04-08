//
//  StartScreenView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct StartScreenView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to setup") {
                    path.append(.setup)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .setup:
                    SetupView(path: $path)
                case .bluetooth:
                    BluetoothConnectionView(path: $path)
                case .wifi:
                    WifiConnectionView(path: $path)
                }
            }
        }
        .padding()
    }
}

#Preview {
    StartScreenView()
}
