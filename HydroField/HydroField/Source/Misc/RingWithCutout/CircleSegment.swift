//
//  CircleSegment.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

struct CircleSegment: Shape {
    var startAngle: Angle
    var endAngle: Angle

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path.strokedPath(StrokeStyle(lineWidth: 5, lineCap: .round))
    }
}
