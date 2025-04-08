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
                
                Button {
                    manager.startScanning()
                } label: {
                    ScanButtonView(isAnimating: $manager.isScanning)
                }
                .padding(.top, 150)
                
                Spacer()
            }
            .onAppear(perform: {
                manager.disconnect()
            })
            .onChange(of: manager.isConnected) { oldValue, newValue in
                if newValue {
                    path.append(.wifi)
                }
            }
            
            VStack {
                Spacer()
                createCurrentStateLabel()
            }
        }
    }
    
    @ViewBuilder
    private func createCurrentStateLabel() -> some View {
        switch manager.managerState {
        case .scanning:
            Text("Looking for supported devices.").font(.caption).foregroundStyle(Color.gray)
        case .connecting:
            Text("Attempting connection to device.").font(.caption).foregroundStyle(Color.gray)
        case .connected:
            Text("Successfully connected to device").font(.caption).foregroundStyle(Color.gray)
        case .error:
            Text("Unable connect to device, try scanning again.").font(.caption).foregroundStyle(Color.gray)
        default:
            EmptyView()
        }
            
    }
}

#Preview {
    BluetoothConnectionView(path: .constant([]))
}
