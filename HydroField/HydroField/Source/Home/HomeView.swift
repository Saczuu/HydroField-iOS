//
//  HomeView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 09/07/2025.
//

import SwiftUI

// MARK: - Model

/// Represents a single device with a unique identifier and a name.
struct Device: Identifiable, Hashable {
    /// Unique identifier for the device.
    let id: UUID = UUID()
    /// Name of the device.
    let name: String
}

// MARK: - ViewModel

/// ViewModel for the HomeView managing the list of devices and the carousel selection.
class HomeViewModel: ObservableObject {
    /// List of devices displayed in the carousel.
    @Published var devices: [Device] = [.init(name: "Fake device")]

    /// Currently selected index in the carousel.
    @Published var carouselSelection: Int = 0
}

// MARK: - View

/// The main view displaying a carousel of devices with an option to add new ones.
struct HomeView: View {

    // MARK: - Observed Objects

    /// The view model providing data and selection state.
    @ObservedObject var viewModel: HomeViewModel = .init()

    // MARK: - Body

    var body: some View {
        VStack {
            createDeviceCarousel()
                .frame(height: 250)

            Divider()

            Spacer()

            Text("TODO")

            Spacer()
        }
    }

    // MARK: - Private Views

    /// Creates the carousel view displaying devices and a trailing button to add new devices.
    /// - Returns: A view containing the device carousel with add button.
    private func createDeviceCarousel() -> some View {
        CarouselView(
            data: viewModel.devices,
            selection: $viewModel.carouselSelection,
            content: { device in
                Text(device.name)
            },
            trailingView: {
                Button("Add new device") {
                    viewModel.devices.append(
                        .init(name: "New device - \(viewModel.devices.count)")
                    )
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        )
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
