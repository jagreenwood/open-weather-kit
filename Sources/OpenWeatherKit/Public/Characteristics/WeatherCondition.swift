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
    case blizzard = "blizzard"

    case blowingDust = "blowing_dust"

    case blowingSnow = "blowing_snow"

    case breezy = "breezy"

    case clear = "clear"

    case cloudy = "cloudy"

    case drizzle = "drizzle"

    case flurries = "flurries"

    case foggy = "foggy"

    case freezingDrizzle = "freezing_drizzle"

    case freezingRain = "freezing_rain"

    case frigid = "frigid"

    case hail = "hail"

    case haze = "haze"

    case heavyRain = "heavy_rain"

    case heavySnow = "heavy_snow"

    case hot = "hot"

    case hurricane = "hurricane"

    case isolatedThunderstorms = "isolated_thunderstorms"

    case mostlyClear = "mostly_clear"

    case mostlyCloudy = "mostly_cloudy"

    case partlyCloudy = "partly_cloudy"

    case rain = "rain"

    case scatteredThunderstorms = "scattered_thunderstorms"

    case sleet = "sleet"

    case smoky = "smoky"

    case snow = "snow"

    case strongStorms = "strong_storms"

    case sunFlurries = "sun_flurries"

    case sunShowers = "sun_showers"

    case thunderstorms = "thunderstorms"

    case tropicalStorm = "tropical_storm"

    case undefined = "undefined"

    case windy = "windy"

    case wintryMix = "wintry_mix"

    /// Standard string describing the current condition.
    public var description: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.blizzard", bundle: Bundle.module, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.blowingDust", bundle: Bundle.module, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.blowingSnow", bundle: Bundle.module, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.breezy", bundle: Bundle.module, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.clear", bundle: Bundle.module, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.cloudy", bundle: Bundle.module, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.drizzle", bundle: Bundle.module, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.flurries", bundle: Bundle.module, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.foggy", bundle: Bundle.module, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.freezingDrizzle", bundle: Bundle.module, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.freezingRain", bundle: Bundle.module, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.frigid", bundle: Bundle.module, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.hail", bundle: Bundle.module, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.haze", bundle: Bundle.module, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.heavyRain", bundle: Bundle.module, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.heavySnow", bundle: Bundle.module, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.hot", bundle: Bundle.module, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.hurricane", bundle: Bundle.module, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.isolatedThunderstorms", bundle: Bundle.module, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.mostlyClear", bundle: Bundle.module, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.mostlyCloudy", bundle: Bundle.module, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.partlyCloudy", bundle: Bundle.module, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.rain", bundle: Bundle.module, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.scatteredThunderstorms", bundle: Bundle.module, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.sleet", bundle: Bundle.module, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.smoky", bundle: Bundle.module, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.snow", bundle: Bundle.module, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.strongStorms", bundle: Bundle.module, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.sunFlurries", bundle: Bundle.module, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.sunShowers", bundle: Bundle.module, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.thunderstorms", bundle: Bundle.module, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.tropicalStorm", bundle: Bundle.module, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.undefined", bundle: Bundle.module, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.windy", bundle: Bundle.module, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.wintryMix", bundle: Bundle.module, comment: "Wintry Mix")
        }
    }

    /// A localized accessibility description describing the weather condition, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.accessibility.blizzard", bundle: Bundle.module, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.accessibility.blowingDust", bundle: Bundle.module, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.accessibility.blowingSnow", bundle: Bundle.module, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.accessibility.breezy", bundle: Bundle.module, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.accessibility.clear", bundle: Bundle.module, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.accessibility.cloudy", bundle: Bundle.module, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.accessibility.drizzle", bundle: Bundle.module, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.accessibility.flurries", bundle: Bundle.module, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.accessibility.foggy", bundle: Bundle.module, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.accessibility.freezingDrizzle", bundle: Bundle.module, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.accessibility.freezingRain", bundle: Bundle.module, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.accessibility.frigid", bundle: Bundle.module, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.accessibility.hail", bundle: Bundle.module, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.accessibility.haze", bundle: Bundle.module, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.accessibility.heavyRain", bundle: Bundle.module, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.accessibility.heavySnow", bundle: Bundle.module, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.accessibility.hot", bundle: Bundle.module, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.accessibility.hurricane", bundle: Bundle.module, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.isolatedThunderstorms", bundle: Bundle.module, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyClear", bundle: Bundle.module, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyCloudy", bundle: Bundle.module, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.partlyCloudy", bundle: Bundle.module, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.accessibility.rain", bundle: Bundle.module, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.scatteredThunderstorms", bundle: Bundle.module, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.accessibility.sleet", bundle: Bundle.module, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.accessibility.smoky", bundle: Bundle.module, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.accessibility.snow", bundle: Bundle.module, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.accessibility.strongStorms", bundle: Bundle.module, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.accessibility.sunFlurries", bundle: Bundle.module, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.accessibility.sunShowers", bundle: Bundle.module, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.thunderstorms", bundle: Bundle.module, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.accessibility.tropicalStorm", bundle: Bundle.module, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.accessibility.undefined", bundle: Bundle.module, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.accessibility.windy", bundle: Bundle.module, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.accessibility.wintryMix", bundle: Bundle.module, comment: "Wintry Mix")
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
