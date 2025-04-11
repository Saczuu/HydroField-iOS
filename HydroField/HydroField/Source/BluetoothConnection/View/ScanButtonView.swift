//
//  ScanButtonView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

/// A view that represents a circular scan button with animated rings and a "SCAN" label.
/// The button rotates the rings when the animation is triggered by the `isAnimating` binding.
struct ScanButtonView: View {

    // MARK: - Properties

    /// The current rotation angle for the rings' animation.
    @State private var rotation: Double = 0

    /// A binding that controls whether the scan animation is active.
    @Binding var isAnimating: Bool

    // MARK: - View Body

    var body: some View {
        ZStack {
            // Main circle background with "SCAN" label
            Circle()
                .fill(Color.green)
                .frame(width: 200, height: 200)
                .overlay(
                    Text("SCAN")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                        .blendMode(.destinationOut)  // Makes the text cut out from the circle
                )
                .compositingGroup()

            // First rotating ring with cutouts
            RingWithCutout(segmentGap: .degrees(8), segmentCount: 13)
                .frame(width: 210, height: 210)
                .foregroundStyle(Color.green)
                .rotationEffect(.degrees(rotation))

            // Second rotating ring with slightly different rotation
            RingWithCutout(segmentGap: .degrees(5), segmentCount: 13)
                .frame(width: 225, height: 225)
                .foregroundStyle(Color.green)
                .rotationEffect(.degrees(-rotation - 12)) // Slightly different rotation
        }
        .onChange(of: isAnimating) { newValue in
            if newValue {
                // Start the animation only if isAnimating is true
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation = 360  // Rotate the rings continuously
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ScanButtonView(isAnimating: .constant(false))
}
