//
//  StartScreenView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 05/04/2025.
//

import SwiftUI

/// The starting point for the configuration flow of a new HydroField app instance.
/// This screen introduces the app and provides a call-to-action to begin setup.
struct StartScreenView: View {
    
    // MARK: - Properties

    /// A binding to the navigation path used for controlling screen transitions.
    @Binding var path: [Route]

    // MARK: - View Body

    var body: some View {
        VStack() {
            createAppLogo()
            createWelcomeText()
            createStartButton()
            Spacer()
        }
        .padding()
    }

    // MARK: - Private View Components

    /// Creates the app logo view.
    private func createAppLogo() -> some View {
        Image("AppLogo")
            .resizable()
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(radius: 10)
            .padding(.top, 60)
    }

    /// Creates the welcome title text.
    private func createWelcomeText() -> some View {
        Text("Welcome to HydroField")
            .font(.largeTitle)
            .fontWeight(.bold)
    }

    /// Creates the "Let's start" button.
    private func createStartButton() -> some View {
        Button(action: {
            path.append(.setup)
        }) {
            Text("Let's start")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding([.leading, .trailing], 35)
                .background(Color.green)
                .cornerRadius(12)
                .padding(.horizontal, 40)
                .shadow(radius: 5)
        }
    }
}

// MARK: - Preview

#Preview {
    StartScreenView(path: .constant([]))
}
