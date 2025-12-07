//
//  PlantCarouselView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/12/2025.
//

import SwiftUI

struct PlantCarouselView: View {
    
    @State var viewModel: ViewModel = .init()
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.plants, id: \.self) { plant in
                        Text(plant)
                            .font(.largeTitle)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}

extension PlantCarouselView {
    @Observable
    class ViewModel {
        var plants: [String] = ["Plant A", "Plant B", "Plant C", "Plant F", "Plant G", "Plant H", "Plant I", "Plant J", "Plant K", "Plant L"]
    }
}

// MARK: - Preview

#Preview {
    PlantCarouselView()
}
