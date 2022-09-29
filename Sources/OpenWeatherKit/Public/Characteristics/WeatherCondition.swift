//
//  WeatherCondition.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

import Foundation

public enum WeatherCondition : String, CaseIterable, CustomStringConvertible, Hashable {

    /// The kind of condition.
    case blizzard

    case blowingDust

    case blowingSnow

    case breezy

    case clear

    case cloudy

    case drizzle

    case flurries

    case foggy

    case freezingDrizzle

    case freezingRain

    case frigid

    case hail

    case haze

    case heavyRain

    case heavySnow

    case hot

    case hurricane

    case isolatedThunderstorms

    case mostlyClear

    case mostlyCloudy

    case partlyCloudy

    case rain

    case scatteredThunderstorms

    case sleet

    case smoky

    case snow

    case strongStorms

    case sunFlurries

    case sunShowers

    case thunderstorms

    case tropicalStorm

    case undefined

    case windy

    case wintryMix

    /// Standard string describing the current condition.
    public var description: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.blizzard", bundle: BundleLocator.bundle, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.blowingDust", bundle: BundleLocator.bundle, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.blowingSnow", bundle: BundleLocator.bundle, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.breezy", bundle: BundleLocator.bundle, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.clear", bundle: BundleLocator.bundle, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.cloudy", bundle: BundleLocator.bundle, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.drizzle", bundle: BundleLocator.bundle, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.flurries", bundle: BundleLocator.bundle, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.foggy", bundle: BundleLocator.bundle, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.freezingDrizzle", bundle: BundleLocator.bundle, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.freezingRain", bundle: BundleLocator.bundle, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.frigid", bundle: BundleLocator.bundle, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.hail", bundle: BundleLocator.bundle, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.haze", bundle: BundleLocator.bundle, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.heavyRain", bundle: BundleLocator.bundle, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.heavySnow", bundle: BundleLocator.bundle, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.hot", bundle: BundleLocator.bundle, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.hurricane", bundle: BundleLocator.bundle, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.isolatedThunderstorms", bundle: BundleLocator.bundle, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.mostlyClear", bundle: BundleLocator.bundle, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.mostlyCloudy", bundle: BundleLocator.bundle, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.partlyCloudy", bundle: BundleLocator.bundle, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.rain", bundle: BundleLocator.bundle, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.scatteredThunderstorms", bundle: BundleLocator.bundle, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.sleet", bundle: BundleLocator.bundle, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.smoky", bundle: BundleLocator.bundle, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.snow", bundle: BundleLocator.bundle, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.strongStorms", bundle: BundleLocator.bundle, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.sunFlurries", bundle: BundleLocator.bundle, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.sunShowers", bundle: BundleLocator.bundle, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.thunderstorms", bundle: BundleLocator.bundle, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.tropicalStorm", bundle: BundleLocator.bundle, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.undefined", bundle: BundleLocator.bundle, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.windy", bundle: BundleLocator.bundle, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.wintryMix", bundle: BundleLocator.bundle, comment: "Wintry Mix")
        }
    }

    /// A localized accessibility description describing the weather condition, suitable for
    /// Voice Over and other assistive technologies.
    public var accessibilityDescription: String {
        switch self {
        case .blizzard:
            return NSLocalizedString("WeatherCondition.accessibility.blizzard", bundle: BundleLocator.bundle, comment: "Blizzard")
        case .blowingDust:
            return NSLocalizedString("WeatherCondition.accessibility.blowingDust", bundle: BundleLocator.bundle, comment: "Blowing Dust")
        case .blowingSnow:
            return NSLocalizedString("WeatherCondition.accessibility.blowingSnow", bundle: BundleLocator.bundle, comment: "Blowing Snow")
        case .breezy:
            return NSLocalizedString("WeatherCondition.accessibility.breezy", bundle: BundleLocator.bundle, comment: "Breezy")
        case .clear:
            return NSLocalizedString("WeatherCondition.accessibility.clear", bundle: BundleLocator.bundle, comment: "Clear")
        case .cloudy:
            return NSLocalizedString("WeatherCondition.accessibility.cloudy", bundle: BundleLocator.bundle, comment: "Cloudy")
        case .drizzle:
            return NSLocalizedString("WeatherCondition.accessibility.drizzle", bundle: BundleLocator.bundle, comment: "Drizzle")
        case .flurries:
            return NSLocalizedString("WeatherCondition.accessibility.flurries", bundle: BundleLocator.bundle, comment: "Flurries")
        case .foggy:
            return NSLocalizedString("WeatherCondition.accessibility.foggy", bundle: BundleLocator.bundle, comment: "Foggy")
        case .freezingDrizzle:
            return NSLocalizedString("WeatherCondition.accessibility.freezingDrizzle", bundle: BundleLocator.bundle, comment: "Freezing Drizzle")
        case .freezingRain:
            return NSLocalizedString("WeatherCondition.accessibility.freezingRain", bundle: BundleLocator.bundle, comment: "Freezing Rain")
        case .frigid:
            return NSLocalizedString("WeatherCondition.accessibility.frigid", bundle: BundleLocator.bundle, comment: "Frigid")
        case .hail:
            return NSLocalizedString("WeatherCondition.accessibility.hail", bundle: BundleLocator.bundle, comment: "Hail")
        case .haze:
            return NSLocalizedString("WeatherCondition.accessibility.haze", bundle: BundleLocator.bundle, comment: "Haze")
        case .heavyRain:
            return NSLocalizedString("WeatherCondition.accessibility.heavyRain", bundle: BundleLocator.bundle, comment: "Heavy Rain")
        case .heavySnow:
            return NSLocalizedString("WeatherCondition.accessibility.heavySnow", bundle: BundleLocator.bundle, comment: "Heavy Snow")
        case .hot:
            return NSLocalizedString("WeatherCondition.accessibility.hot", bundle: BundleLocator.bundle, comment: "Hot")
        case .hurricane:
            return NSLocalizedString("WeatherCondition.accessibility.hurricane", bundle: BundleLocator.bundle, comment: "Hurricane")
        case .isolatedThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.isolatedThunderstorms", bundle: BundleLocator.bundle, comment: "Isolated Thunderstorms")
        case .mostlyClear:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyClear", bundle: BundleLocator.bundle, comment: "Mostly Clear")
        case .mostlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.mostlyCloudy", bundle: BundleLocator.bundle, comment: "Mostly Cloudy")
        case .partlyCloudy:
            return NSLocalizedString("WeatherCondition.accessibility.partlyCloudy", bundle: BundleLocator.bundle, comment: "Partly Cloudy")
        case .rain:
            return NSLocalizedString("WeatherCondition.accessibility.rain", bundle: BundleLocator.bundle, comment: "Rain")
        case .scatteredThunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.scatteredThunderstorms", bundle: BundleLocator.bundle, comment: "Scattered Thunderstorms")
        case .sleet:
            return NSLocalizedString("WeatherCondition.accessibility.sleet", bundle: BundleLocator.bundle, comment: "Sleet")
        case .smoky:
            return NSLocalizedString("WeatherCondition.accessibility.smoky", bundle: BundleLocator.bundle, comment: "Smoky")
        case .snow:
            return NSLocalizedString("WeatherCondition.accessibility.snow", bundle: BundleLocator.bundle, comment: "Snow")
        case .strongStorms:
            return NSLocalizedString("WeatherCondition.accessibility.strongStorms", bundle: BundleLocator.bundle, comment: "StrongStorms")
        case .sunFlurries:
            return NSLocalizedString("WeatherCondition.accessibility.sunFlurries", bundle: BundleLocator.bundle, comment: "Sun Flurries")
        case .sunShowers:
            return NSLocalizedString("WeatherCondition.accessibility.sunShowers", bundle: BundleLocator.bundle, comment: "Sun Showers")
        case .thunderstorms:
            return NSLocalizedString("WeatherCondition.accessibility.thunderstorms", bundle: BundleLocator.bundle, comment: "Thunderstorms")
        case .tropicalStorm:
            return NSLocalizedString("WeatherCondition.accessibility.tropicalStorm", bundle: BundleLocator.bundle, comment: "Tropical Storm")
        case .undefined:
            return NSLocalizedString("WeatherCondition.accessibility.undefined", bundle: BundleLocator.bundle, comment: "undefined")
        case .windy:
            return NSLocalizedString("WeatherCondition.accessibility.windy", bundle: BundleLocator.bundle, comment: "Windy")
        case .wintryMix:
            return NSLocalizedString("WeatherCondition.accessibility.wintryMix", bundle: BundleLocator.bundle, comment: "Wintry Mix")
        }
    }
}

extension WeatherCondition {
    #warning("Implement sfSymbol")
    var sfSymbol: String {
        switch self {
        case .blizzard: return ""
        case .blowingDust: return ""
        case .blowingSnow: return ""
        case .breezy: return ""
        case .clear: return ""
        case .cloudy: return ""
        case .drizzle: return ""
        case .flurries: return ""
        case .foggy: return ""
        case .freezingDrizzle: return ""
        case .freezingRain: return ""
        case .frigid: return ""
        case .hail: return ""
        case .haze: return ""
        case .heavyRain: return ""
        case .heavySnow: return ""
        case .hot: return ""
        case .hurricane: return ""
        case .isolatedThunderstorms: return ""
        case .mostlyClear: return ""
        case .mostlyCloudy: return ""
        case .partlyCloudy: return ""
        case .rain: return ""
        case .scatteredThunderstorms: return ""
        case .sleet: return ""
        case .smoky: return ""
        case .snow: return ""
        case .strongStorms: return ""
        case .sunFlurries: return ""
        case .sunShowers: return ""
        case .thunderstorms: return ""
        case .tropicalStorm: return ""
        case .undefined: return ""
        case .windy: return ""
        case .wintryMix: return ""
        }
    }
}

extension WeatherCondition: Codable {}
extension WeatherCondition: Equatable {}
