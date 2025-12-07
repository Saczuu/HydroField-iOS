//
//  QuoteOfTheDayViewModel.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/12/2025.
//

import SwiftUI

extension QuoteOfTheDayView {
    @Observable
    class ViewModel {
        var quote: String = ""
        
        public func generateQuote() async {
            Task {
                quote = "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit,\nsed do."
            }
        }
    }
}
