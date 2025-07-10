//
//  CarouselView.swift
//  HydroField
//
//  Created by Maciej Sączewski on 09/07/2025.
//

import SwiftUI

// MARK: - CarouselView

/// A generic carousel view that displays a horizontally swipeable collection of views.
/// Supports an optional trailing view displayed as the last page with a distinctive page indicator.
///
/// - Parameters:
///   - Data: The type of the collection to display. Must conform to `RandomAccessCollection` with `Hashable` elements.
///   - Content: The type of view used to display each element in the carousel.
///   - TrailingContent: The type of view used for the optional trailing view.
struct CarouselView<Data: RandomAccessCollection, Content: View, TrailingContent: View>: View where Data.Element: Hashable {

    // MARK: - Properties

    /// The data collection to display.
    let data: Data

    /// A closure that creates the view for each data element.
    let content: (Data.Element) -> Content

    /// An optional trailing view to display as the last page.
    let trailingView: (() -> TrailingContent)?

    /// The currently selected page index.
    @Binding var selection: Int

    // MARK: - Initializer

    /// Creates a new `CarouselView`.
    ///
    /// - Parameters:
    ///   - data: The data collection to display.
    ///   - selection: A binding to the currently selected page index.
    ///   - content: A view builder closure that creates the content view for each element.
    ///   - trailingView: An optional view builder closure that creates a trailing view to display as the last page.
    init(
        data: Data,
        selection: Binding<Int>,
        @ViewBuilder content: @escaping (Data.Element) -> Content,
        trailingView: (() -> TrailingContent)? = nil
    ) {
        self.data = data
        self._selection = selection
        self.content = content
        self.trailingView = trailingView
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 16) {
            // Carousel TabView
            TabView(selection: $selection) {
                ForEach(Array(data.enumerated()), id: \.element) { index, item in
                    content(item)
                        .tag(index)
                }

                if let trailingView = trailingView {
                    trailingView()
                        .tag(data.count)
                }
            }
            .tabViewStyle(.page)

            // Custom page indicator dots
            HStack(spacing: 8) {
                let totalPages = data.count + (trailingView != nil ? 1 : 0)
                ForEach(0..<totalPages, id: \.self) { index in
                    if index == totalPages - 1 {
                        // Trailing view dot: filled when selected, outlined otherwise
                        Circle()
                            .fill(index == selection ? Color.primary : Color.clear)
                            .overlay(
                                Circle()
                                    .stroke(Color.secondary.opacity(0.4))
                            )
                            .frame(width: 8, height: 8)
                    } else {
                        // Regular dots: filled when selected, faded otherwise
                        Circle()
                            .fill(index == selection ? Color.primary : Color.secondary.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("CarouselView with trailing view") {
    struct PreviewWrapper: View {
        @State private var selection = 0
        let items = ["One", "Two", "Three"]

        var body: some View {
            CarouselView(data: items, selection: $selection) { item in
                VStack {
                    Text(item)
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(12)
                }
            } trailingView: {
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                    Text("Add New")
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(12)
            }
        }
    }

    return PreviewWrapper()
}

#Preview("CarouselView with only trailing view") {
    CarouselView(data: [String](), selection: .constant(0)) { object in
        Text("\(object)")
    } trailingView: {
        Text("This is trailing view, which also shows on empty array")
    }
}
