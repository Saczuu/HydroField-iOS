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
        NavigationStack {
            QuoteOfTheDayView()
                .toolbar {
                    HomeToolBarContent()
                }
        }
    }
}


// MARK: - Preview

#Preview {
    HomeView()
}

