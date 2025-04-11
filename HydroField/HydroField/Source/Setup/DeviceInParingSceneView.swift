//
//  ThreeDObjectView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/04/2025.
//

import SwiftUI
import SceneKit

/// A view that renders a 3D scene for a device in pairing mode.
/// The scene is loaded from a `.scn` file, and a specific node (device) is animated to rotate indefinitely.
struct DeviceInParingSceneView: View {
    
    // MARK: - Properties

    /// The 3D scene loaded from the "temp_object.scn" file in the app's main bundle.
    var scene: SCNScene {
        // Load the scene from the main bundle
        guard let scene = SCNScene(named: "temp_object.scn") else {
            fatalError("Could not load scene.")
        }
        return scene
    }

    // MARK: - View Body

    var body: some View {
        SceneView(
            scene: scene,
            pointOfView: nil,
            options: [.autoenablesDefaultLighting, .allowsCameraControl]
        )
        .scaledToFit()

    }
}

// MARK: - Preview

#Preview {
    DeviceInParingSceneView()
}
