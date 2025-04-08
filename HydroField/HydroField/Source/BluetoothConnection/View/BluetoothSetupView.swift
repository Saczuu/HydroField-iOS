//
//  BluetoothConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct BluetoothConnectionView: View {
    @ObservedObject var manager: BluetoothManager = .shared
    @Binding var path: [Route]

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text("Bluetooth: \(manager.managerState)")
                    .font(.title2)
                    .padding()

                Button {
                    manager.startScanning()
                } label: {
                    ScanButtonView(isAnimating: $manager.isScanning)
                }
                .padding(.top, 100)

                Spacer()
            }
            .onDisappear {
                manager.stopScanning()
            }
            .onChange(of: manager.isConnected) { oldValue, newValue in
                if newValue {
                    path.append(.wifi)
                }
            }
        }
        .navigationTitle("Bluetooth Connection")
    }
}

#Preview {
    BluetoothConnectionView(path: .constant([]))
}
