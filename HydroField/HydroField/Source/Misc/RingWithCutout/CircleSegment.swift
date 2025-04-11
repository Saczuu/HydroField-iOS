//
//  CircleSegment.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

/// A custom shape representing a circular segment, defined by a start and end angle.
/// This shape is used to draw a portion of a circle based on the given angles.
struct CircleSegment: Shape {

    // MARK: - Properties

    /// The starting angle of the segment.
    var startAngle: Angle

    /// The ending angle of the segment.
    var endAngle: Angle

    // MARK: - Methods

    /// Creates the path for the circle segment within the given rectangle.
    /// - Parameter rect: The rectangle in which to draw the segment.
    /// - Returns: A `Path` representing the circular segment.
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Calculate the radius and center of the circle
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)

        // Add an arc to the path based on the start and end angles
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)

        // Return the path with a stroke style
        return path.strokedPath(StrokeStyle(lineWidth: 5, lineCap: .round))
    }
}

