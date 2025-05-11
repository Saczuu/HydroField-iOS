//
//  HydroFieldView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/04/2025.
//

import SwiftUI

/// The main view for the HydroField application.
/// Displays the onboarding and setup flow based on the current application state.
struct HydroFieldView: View {
    
    // MARK: - State
    
    /// The current state of the app. Used to determine which screen to show.
    /// TODO: Move state to persistent storage like Core Data or UserDefaults.
    @State private var state: AppState = .unconfigured
    
    /// The navigation path for programmatic navigation within the app.
    @State private var path: [Route] = []

    // MARK: - View Body
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch state {
                case .unconfigured:
                    /// Display setup view when the app is not configured.
                    StartScreenView(path: $path)
                case .configured:
                    /// In future, this may direct to the main screen instead.
                    StartScreenView(path: $path)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .setup:
                    SetupView(path: $path)
                case .bluetooth:
                    BluetoothConnectionView(path: $path)
                case .wifiList:
                    WifiConnectionListView(path: $path)
                case .wifiConfig(let connection):
                    WifiConnectionConfigView(path: $path,
                                             connection: connection)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HydroFieldView()
}
