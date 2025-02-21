//
//  APIPrecipitationAmountByType.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/21/25.
//

import Foundation

// MARK: - APIPrecipitationAmountByType
struct APIPrecipitationAmountByType: Codable, Equatable {
    let expected: Double
    let expectedSnow: Double
    let maximumSnow: Double
    let minimumSnow: Double
    let precipitationType: PrecipitationType

    enum CodingKeys: String, CodingKey {
        case expected = "expected"
        case expectedSnow = "expectedSnow"
        case maximumSnow = "maximumSnow"
        case minimumSnow = "minimumSnow"
        case precipitationType = "precipitationType"
    }

    enum PrecipitationType: String, Codable, Equatable {
        case hail = "HAIL"
        case mixed = "MIXED"
        case rain = "RAIN"
        case sleet = "SLEET"
        case snow = "SNOW"
    }
}

extension Array where Element == APIPrecipitationAmountByType {
    var precipitationAmountByType: PrecipitationAmountByType {
        var amountByType = PrecipitationAmountByType(
            hail: .zeroMillimeters,
            mixed: .zeroMillimeters,
            rainfall: .zeroMillimeters,
            sleet: .zeroMillimeters,
            precipitation: .zeroMillimeters,
            snowfallAmount: SnowfallAmount(
                amount: .zeroMillimeters,
                maximum: .zeroMillimeters,
                minimum: .zeroMillimeters,
                amountLiquidEquivalent: .zeroMillimeters,
                maximumLiquidEquivalent: .zeroMillimeters,
                minimumLiquidEquivalent: .zeroMillimeters
            )
        )

        for element in self {
            switch element.precipitationType {
            case .hail:
                amountByType.hail = .millimeters(element.expected)
            case .mixed:
                amountByType.mixed = .millimeters(element.expected)
            case .rain:
                amountByType.rainfall = .millimeters(element.expected)
            case .sleet:
                amountByType.sleet = .millimeters(element.expected)
            case .snow:
                amountByType.snowfallAmount = SnowfallAmount(
                    amount: .millimeters(element.expectedSnow),
                    maximum: .millimeters(element.maximumSnow),
                    minimum: .millimeters(element.minimumSnow),
                    amountLiquidEquivalent: .millimeters(element.expectedSnow / 10.0), // assuming 10: snow to liquid ratio
                    maximumLiquidEquivalent: .millimeters(element.maximumSnow / 10.0),
                    minimumLiquidEquivalent: .millimeters(element.minimumSnow / 10.0)
                )
            }
        }

        return amountByType
    }
}
