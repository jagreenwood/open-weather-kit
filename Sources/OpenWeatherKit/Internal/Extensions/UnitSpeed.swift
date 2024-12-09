//
//  UnitSpeed.swift
//  open-weather-kit
//
//  Created by Matthias Kollmann on 20.11.24.
//

import Foundation

extension UnitSpeed {
    static let millimetersPerHour: UnitSpeed = UnitSpeed(symbol: "mm/h", converter: UnitConverterLinear(coefficient: 1.0/3.6))
}
