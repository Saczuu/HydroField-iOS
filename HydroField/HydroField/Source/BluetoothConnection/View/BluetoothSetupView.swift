//
//  BluetoothConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct BluetoothConnectionView: View {
    @State var manager: BluetoothManager = .shared
    
    var body: some View {
        VStack {
            Spacer()
            Text("Bluetooth: \(manager.managerState)")
            Button {
                manager.startScanning()
            } label: {
                Text("Scan")
            }
            .padding([.top], 100)
            Spacer()

        }
    }
}

#Preview {
    BluetoothConnectionView()
}
