//
//  RingWithCutout.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

/// A view that renders a ring with cutout segments.
/// The number of segments and the gap between them are customizable.
struct RingWithCutout: View {

    // MARK: - Properties

    /// The angle between each segment, representing the gap between segments.
    var segmentGap: Angle

    /// The total number of segments in the ring.
    var segmentCount: Double

    /// The size of each segment, calculated based on the total number of segments and the gap.
    var segmentSize: Angle {
        .degrees(
            (360 - (segmentCount * segmentGap.degrees)) / segmentCount
        )
    }

    /// The array of `RingSegment` representing each segment of the ring.
    var segments: [RingSegment] {
        var segments: [RingSegment] = []
        var currentPosition: Double = 0

        // Generate segments based on the segment size and gap
        while currentPosition <= 360 {
            segments.append(
                .init(startAngle: .degrees(currentPosition),
                      endAgnle: .degrees(currentPosition + segmentSize.degrees))
            )

            currentPosition += segmentSize.degrees + segmentGap.degrees
        }

        return segments
    }

    // MARK: - View Body

    @ViewBuilder
    var body: some View {
        ZStack {
            // Render each segment of the ring
            ForEach(segments, id: \.self) { segment in
                CircleSegment(
                    startAngle: segment.startAngle,
                    endAngle: segment.endAgnle
                )
            }
        }
    }
}
