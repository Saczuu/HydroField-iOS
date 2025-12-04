//
//  HomeView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 02/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = ViewModel()
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "leaf.fill")
                .imageScale(.large)
                .foregroundStyle(.green.opacity(0.7))

            Text("Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit,\nsed do.")
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .glassEffect(.regular.tint(.brown.opacity(0.3)))
    }
}


// MARK: - Preview

#Preview {
    HomeView()
}
