//
//  BluetoothConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct BluetoothConnectionView: View {
    @State var btManager = BluetoothConnectionManager()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Bluetooth: \(btManager.isBluetoothEnabled ? "Enabled" : "Disabled")")
            Button {
                btManager.scanForPeripherial()
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
