//
//  QuoteOfTheDayView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/12/2025.
//

import SwiftUI

struct QuoteOfTheDayView: View {
    
    @State var viewModel = ViewModel()
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "leaf.fill")
                .imageScale(.large)
                .foregroundStyle(.green.opacity(0.7))

            Text(viewModel.quote)
                .multilineTextAlignment(.center)
        }
        .padding(25)
        .glassEffect(.regular.tint(.brown.opacity(0.3)))
        .task {
            await viewModel.generateQuote()
        }
    }
}

// MARK: - Preview

#Preview {
    QuoteOfTheDayView()
}
