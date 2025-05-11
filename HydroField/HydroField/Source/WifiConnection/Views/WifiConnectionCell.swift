//
//  WifiConnectionCell.swift
//  HydroField
//
//  Created by Maciej Sączewski on 11/05/2025.
//


import SwiftUI

struct WifiConnectionCell<Content: View>: View {
    // MARK: - Properties
    let content: Content
    
    // MARK: - Initializer
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // MARK: - Body View
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color(.black).opacity(0.05), radius: 2, x: 0, y: 1)
            )
            .padding(.horizontal)
            .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview {
    WifiConnectionCell {
        Text("Some WIFI details")
    }
}