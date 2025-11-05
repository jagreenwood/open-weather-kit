//
//  Measurement+Utils.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/21/25.
//

import Foundation

extension Measurement where UnitType == UnitLength {
    static var zeroMillimeters: Measurement {
        Measurement(value: 0.0, unit: .millimeters)
    }

    static func millimeters(_ value: Double) -> Measurement {
        Measurement(value: value, unit: .millimeters)
    }
}
