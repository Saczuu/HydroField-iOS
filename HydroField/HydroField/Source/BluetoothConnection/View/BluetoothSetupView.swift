//
//  BluetoothConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

/// A view that handles the Bluetooth connection flow, including scanning for devices and connecting to them.
/// Displays the current state of the connection and triggers the appropriate transitions.
struct BluetoothConnectionView: View {

    // MARK: - Properties

    /// The Bluetooth manager responsible for managing the connection state and scanning.
    @ObservedObject var manager: BluetoothManager = .shared

    /// A binding to the navigation path used for controlling screen transitions.
    @Binding var path: [Route]

    // MARK: - View Body

    var body: some View {
        ZStack {
            VStack {
                createBypassButton()
                Spacer()
                // Scan button that triggers Bluetooth scanning
                createScanButton()
                    .padding(.top, 150)

                Spacer()
            }
            .onAppear(perform: {
                manager.disconnect()  // Disconnect when the view appears
            })
            .onChange(of: manager.isConnected) { _, newValue in
                // Transition to Wi-Fi connection view if Bluetooth is connected
                if newValue {
                    path.append(.wifiList)
                }
            }

            // Current state label displayed at the bottom
            VStack {
                Spacer()
                createCurrentStateLabel()
            }
        }
        .navigationTitle("Blutooth pairing")
    }

    // MARK: - Methods
    
    /// Creates the bypass button thats skip bluetooth connection.
    /// - Returns: A `Button` view thats skips bluetooth connection.
    private func createBypassButton() -> some View {
        Button {
            path.append(.wifiList)
        } label: {
            Text("Bypass bluetooth connection")
        }
    }

    /// Creates the scan button view that triggers Bluetooth scanning.
    /// - Returns: A `Button` view that starts scanning for devices.
    private func createScanButton() -> some View {
        Button {
            manager.startScanning()  // Start scanning for Bluetooth devices
        } label: {
            ScanButtonView(isAnimating: $manager.isScanning)  // Animated scan button
        }
    }

    /// Creates the current state label based on the Bluetooth manager's connection state.
    /// - Returns: A label indicating the current Bluetooth connection state.
    @ViewBuilder
    private func createCurrentStateLabel() -> some View {
        switch manager.managerState {
        case .scanning:
            Text("Looking for supported devices.")
                .font(.caption)
                .foregroundStyle(Color.gray)
        case .connecting:
            Text("Attempting connection to device.")
                .font(.caption)
                .foregroundStyle(Color.gray)
        case .connected:
            Text("Successfully connected to device")
                .font(.caption)
                .foregroundStyle(Color.gray)
        case .error:
            Text("Unable to connect to device, try scanning again.")
                .font(.caption)
                .foregroundStyle(Color.gray)
        default:
            EmptyView()  // No label if the state is uninitialized or not defined
        }
    }
}

// MARK: - Preview

#Preview {
    BluetoothConnectionView(path: .constant([]))
}

