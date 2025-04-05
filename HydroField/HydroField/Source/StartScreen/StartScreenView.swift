//
//  StartScreenView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

struct StartScreenView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    SetupView()
                } label: {
                    Text("Go to setup")
                }

            }
        }
        .padding()
    }
}

#Preview {
    StartScreenView()
}
