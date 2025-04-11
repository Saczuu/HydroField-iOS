//
//  SetupView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

/// A setup screen in the HydroField app that introduces the 3D object.
/// Provides a button to proceed to the next step in the configuration flow.
struct SetupView: View {

    // MARK: - Properties

    /// A binding to the navigation path used for controlling screen transitions.
    @Binding var path: [Route]

    // MARK: - View Body

    var body: some View {
        VStack {
            Spacer()
            create3DObject()
            Spacer()
            createNextButton()
        }
        .padding()
    }

    // MARK: - Private View Components

    /// Displays the 3D object view with padding.
    private func create3DObject() -> some View {
        DeviceInParingSceneView()
            .padding()
    }

    /// Creates a styled "Got it!" button to navigate to the Bluetooth setup screen.
    private func createNextButton() -> some View {
        Button(action: {
            path.append(.bluetooth)
        }) {
            Text("Got it!")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(12)
                .padding(.horizontal, 40)
                .shadow(radius: 5)
        }
    }
}

// MARK: - Preview

#Preview {
    SetupView(path: .constant([]))
}

