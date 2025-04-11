//
//  RingSegment.swift
//  HydroField
//
//  Created by Maciej Sączewski on 07/04/2025.
//

import SwiftUI

/// A model representing a single segment of a ring.
/// Each segment is defined by a start angle and an end angle.
struct RingSegment: Hashable {

    // MARK: - Properties

    /// The starting angle of the segment.
    var startAngle: Angle

    /// The ending angle of the segment.
    var endAgnle: Angle  // Corrected spelling of "endAngle" (if necessary)
}
