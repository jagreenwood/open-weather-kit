//
//  WeatherCondition.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

/// A description of the current weather condition.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public enum WeatherCondition : String, CaseIterable, CustomStringConvertible, Hashable, Sendable {

    /// The kind of condition.
    case blizzard = "Blizzard"

    case blowingDust = "BlowingDust"

    case blowingSnow = "BlowingSnow"

    case breezy = "Breezy"

    case clear = "Clear"

    case cloudy = "Cloudy"

    case drizzle = "Drizzle"

    case flurries = "Flurries"

    case foggy = "Foggy"

    case freezingDrizzle = "FreezingDrizzle"

    case freezingRain = "FreezingRain"

    case frigid = "Frigid"

    case hail = "Hail"

    case haze = "Haze"

    case heavyRain = "HeavyRain"

    case heavySnow = "HeavySnow"

    case hot = "Hot"

    case hurricane = "Hurricane"

    case isolatedThunderstorms = "IsolatedThunderstorms"

    case mostlyClear = "MostlyClear"

    case mostlyCloudy = "MostlyCloudy"

    case partlyCloudy = "PartlyCloudy"

    case rain = "Rain"

    case scatteredThunderstorms = "ScatteredThunderstorms"

    case sleet = "Sleet"

    case smoky = "Smoky"

    case snow = "Snow"

    case strongStorms = "StrongStorms"

    case sunFlurries = "SunFlurries"

    case sunShowers = "SunShowers"

    case thunderstorms = "Thunderstorms"

    case tropicalStorm = "TropicalStorm"

    case undefined = "Undefined"

    case windy = "Windy"

    case wintryMix = "WintryMix"

    /// Standard string describing the current condition.
    public var description: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.blizzard", bundle: Bundle.main, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.blowingDust", bundle: Bundle.main, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.blowingSnow", bundle: Bundle.main, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.breezy", bundle: Bundle.main, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.clear", bundle: Bundle.main, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.cloudy", bundle: Bundle.main, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.drizzle", bundle: Bundle.main, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.flurries", bundle: Bundle.main, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.foggy", bundle: Bundle.main, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.freezingDrizzle", bundle: Bundle.main, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.freezingRain", bundle: Bundle.main, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.frigid", bundle: Bundle.main, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.hail", bundle: Bundle.main, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.haze", bundle: Bundle.main, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.heavyRain", bundle: Bundle.main, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.heavySnow", bundle: Bundle.main, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.hot", bundle: Bundle.main, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.hurricane", bundle: Bundle.main, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.isolatedThunderstorms", bundle: Bundle.main, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.mostlyClear", bundle: Bundle.main, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.mostlyCloudy", bundle: Bundle.main, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.partlyCloudy", bundle: Bundle.main, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.rain", bundle: Bundle.main, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.scatteredThunderstorms", bundle: Bundle.main, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.sleet", bundle: Bundle.main, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.smoky", bundle: Bundle.main, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.snow", bundle: Bundle.main, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.strongStorms", bundle: Bundle.main, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.sunFlurries", bundle: Bundle.main, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.sunShowers", bundle: Bundle.main, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.thunderstorms", bundle: Bundle.main, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.tropicalStorm", bundle: Bundle.main, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.undefined", bundle: Bundle.main, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.windy", bundle: Bundle.main, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.wintryMix", bundle: Bundle.main, comment: "Wintry Mix")
        }
    }

    /// A localized accessibility description describing the weather condition, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.accessibility.blizzard", bundle: Bundle.main, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.accessibility.blowingDust", bundle: Bundle.main, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.accessibility.blowingSnow", bundle: Bundle.main, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.accessibility.breezy", bundle: Bundle.main, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.accessibility.clear", bundle: Bundle.main, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.accessibility.cloudy", bundle: Bundle.main, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.accessibility.drizzle", bundle: Bundle.main, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.accessibility.flurries", bundle: Bundle.main, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.accessibility.foggy", bundle: Bundle.main, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.accessibility.freezingDrizzle", bundle: Bundle.main, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.accessibility.freezingRain", bundle: Bundle.main, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.accessibility.frigid", bundle: Bundle.main, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.accessibility.hail", bundle: Bundle.main, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.accessibility.haze", bundle: Bundle.main, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.accessibility.heavyRain", bundle: Bundle.main, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.accessibility.heavySnow", bundle: Bundle.main, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.accessibility.hot", bundle: Bundle.main, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.accessibility.hurricane", bundle: Bundle.main, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.isolatedThunderstorms", bundle: Bundle.main, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyClear", bundle: Bundle.main, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyCloudy", bundle: Bundle.main, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.partlyCloudy", bundle: Bundle.main, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.accessibility.rain", bundle: Bundle.main, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.scatteredThunderstorms", bundle: Bundle.main, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.accessibility.sleet", bundle: Bundle.main, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.accessibility.smoky", bundle: Bundle.main, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.accessibility.snow", bundle: Bundle.main, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.accessibility.strongStorms", bundle: Bundle.main, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.accessibility.sunFlurries", bundle: Bundle.main, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.accessibility.sunShowers", bundle: Bundle.main, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.thunderstorms", bundle: Bundle.main, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.accessibility.tropicalStorm", bundle: Bundle.main, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.accessibility.undefined", bundle: Bundle.main, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.accessibility.windy", bundle: Bundle.main, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.accessibility.wintryMix", bundle: Bundle.main, comment: "Wintry Mix")
        }
    }
}

extension WeatherCondition {
    var sfSymbol: String {
        switch self {
        case .blizzard: return "wind.snow"
        case .blowingDust: return "sun.dust"
        case .blowingSnow: return "wind.snow"
        case .breezy: return "wind"
        case .clear: return "sun.max"
        case .cloudy: return "cloud"
        case .drizzle: return "cloud.drizzle"
        case .flurries: return "cloud.snow"
        case .foggy: return "cloud.fog"
        case .freezingDrizzle: return "cloud.sleet"
        case .freezingRain: return "cloud.sleet"
        case .frigid: return "thermometer.low"
        case .hail: return "cloud.hail"
        case .haze: return "sun.haze"
        case .heavyRain: return "cloud.heavyrain"
        case .heavySnow: return "cloud.snow"
        case .hot: return "thermometer.high"
        case .hurricane: return "hurricane"
        case .isolatedThunderstorms: return "cloud.bolt"
        case .mostlyClear: return "cloud.sun"
        case .mostlyCloudy: return "cloud.sun"
        case .partlyCloudy: return "cloud.sun"
        case .rain: return "cloud.rain"
        case .scatteredThunderstorms: return "cloud.bolt"
        case .sleet: return "cloud.sleet"
        case .smoky: return "smoke"
        case .snow: return "snowflake"
        case .strongStorms: return "cloud.heavyrain"
        case .sunFlurries: return "snowflake"
        case .sunShowers: return "cloud.sun.rain"
        case .thunderstorms: return "cloud.bolt.rain"
        case .tropicalStorm: return "cloud.rain"
        case .undefined: return "exclamationmark.triangle"
        case .windy: return "wind"
        case .wintryMix: return "cloud.sleet"
        }
    }
}

extension WeatherCondition: Codable {}
extension WeatherCondition: Equatable {}
