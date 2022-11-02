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
