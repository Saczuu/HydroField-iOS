//
//  ScanButtonView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

struct ScanButtonView: View {
    @State var rotation: Double = 0
    @Binding var isAnimating: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .frame(width: 200, height: 200)
                .overlay(
                    Text("SCAN")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                        .blendMode(.destinationOut)
                )
                .compositingGroup()

            RingWithCutout(segmentGap: .degrees(8), segmentCount: 13)
                .frame(width: 210, height: 210)
                .foregroundStyle(Color.green)
                .rotationEffect(.degrees(rotation))

            RingWithCutout(segmentGap: .degrees(5), segmentCount: 13)
                .frame(width: 225, height: 225)
                .foregroundStyle(Color.green)
                .rotationEffect(.degrees(-rotation - 12)) // Slightly different rotation
        }
        .onAppear {
            if isAnimating {
                // Start the animation only if isAnimating is true
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation = isAnimating ? 360 : 0
                }
            }
        }
        .onChange(of: isAnimating) {
            if isAnimating {
                // Start the animation only if isAnimating is true
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }
    }
}

#Preview {
    Spacer()
    ScanButtonView(isAnimating: .constant(false))
    Spacer()
    ScanButtonView(isAnimating: .constant(true))
    Spacer()
}
