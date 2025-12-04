//
//  HydroFieldView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/04/2025.
//

import SwiftUI

/// The main view for the HydroField application.
/// Displays the onboarding and setup flow based on the current application state.
struct HydroFieldView: View {
    
    // MARK: - State
    /// The navigation path for programmatic navigation within the app.
    @State private var path: [Route] = []

    // MARK: - View Body
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HomeView()
            }
            .navigationDestination(for: Route.self) { route in

            }
        }
    }
}

// MARK: - Preview

#Preview {
    HydroFieldView()
}
