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
        }
    }
}

#Preview {
    BluetoothConnectionView(path: .constant([]))
}
