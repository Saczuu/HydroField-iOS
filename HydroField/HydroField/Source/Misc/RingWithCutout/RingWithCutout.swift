//
//  RingWithCutout.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

struct RingWithCutout: View {
    var segmentGap: Angle
    var segmentCount: Double

    var segmentSize: Angle {
        .degrees(
            (360 - (segmentCount * segmentGap.degrees))/segmentCount
        )
    }

    var segments: [RingSegment] {
        var segments: [RingSegment] = []
        var currentPossition: Double = 0
        while currentPossition <= 360 {
            segments.append(
                .init(startAngle: .degrees(currentPossition),
                      endAgnle: .degrees(currentPossition + segmentSize.degrees))
            )

            currentPossition += segmentSize.degrees + segmentGap.degrees
        }

        return segments
    }

    @ViewBuilder
    var body: some View {
        ZStack {
            ForEach(segments, id: \.self) { segment in
                CircleSegment(
                    startAngle: segment.startAngle,
                    endAngle: segment.endAgnle
                )
            }
        }
    }
}
