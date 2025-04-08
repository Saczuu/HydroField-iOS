//
//  SetupView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct SetupView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack {
            Spacer()
            Text("Maybe some fancy animation about\n  turning farm into pairing mode.")
            Spacer()
            Button("Got it!") {
                path.append(.bluetooth)
            }
            .fontWeight(.semibold)
            .foregroundStyle(Color.green)
        }
    }
}

#Preview {
    SetupView(path: .constant([]))
}
