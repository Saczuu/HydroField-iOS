//
//  WifiConnectionView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 08/04/2025.
//

import SwiftUI

struct WifiConnectionView: View {
    @Binding var path: [Route]
    
    var body: some View {
        VStack {
            Spacer()
            Text("Configure your Wi-Fi here")
            Spacer()
            // Add your Wi-Fi logic
        }
    }
}

#Preview {
    WifiConnectionView(path: .constant([]))
}
