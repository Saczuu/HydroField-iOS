//
//  SetupView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct SetupView: View {
    var body: some View {
        VStack {
            Text("Inital setup information, then move to bluetooth.")
            Text("Maybe some fancy animation about turning on farm.")
            Spacer()
            NavigationLink {
                BluetoothConnectionView()
            } label: {
                Text("Scan for device")
            }

        }
    }
}

#Preview {
    SetupView()
}
