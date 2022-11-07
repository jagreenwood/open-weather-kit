//
//  SunEvents.swift
//  
//
//  Created by Jeremy Greenwood on 8/28/22.
//

@preconcurrency import Foundation

public struct SunEvents: Sendable {

    /// The time of astronomical sunrise when the sun’s center is 18° below the horizon.
    ///
    /// A small portion
    /// of the sun's rays begin to illuminate the sky and stars begin to disappear. This property is
    /// optional because it's possible for the sun to not rise on a given day, at extreme latitudes.
    public var astronomicalDawn: Date?

    /// The time of nautical sunrise when the sun’s center is 12° below the horizon.
    ///
    /// There is enough light
    /// for sailors to distinguish the horizon at sea, but the sky is too dark for outdoor activities. This
    /// property is optional because it's possible for the sun to not rise on a given day, at extreme latitudes.
    public var nauticalDawn: Date?

    /// The time of civil sunrise when the sun’s center is 6° below the horizon.
    ///
    /// Civil dawn begins when
    /// there's enough light for most objects to be seen, so it's often used to determine when outdoor
    /// activities may begin. This property is optional because it's possible for the sun to not rise on a
    /// given day, at extreme latitudes.
    public var civilDawn: Date?

    /// The sunrise time immediately before the solar transit closest to calendar noon.
    ///
    /// This property is
    /// optional because it's possible for the sun to not rise on a given day, at extreme latitudes. That calendar noon is used as a reference point due to variations in frequency of solar events at
    /// extreme latitudes.
    public var sunrise: Date?

    /// Represents solar noon, the time when the sun reaches its highest point in the sky.
    ///
    /// It may or
    /// may not be above the horizon at this time due to variations of solar events at extreme latitudes.
    /// If the highest point isn't above the horizon, this property is ``nil``.
    public var solarNoon: Date?

    /// The sunset time immediately after the solar transit closest to calendar noon.
    ///
    /// This property is
    /// optional because it's possible for the sun to not set on a given day, at extreme latitudes. That calendar noon is used as a reference point due to variations in frequency of solar events at
    /// extreme latitudes.
    public var sunset: Date?

    /// The time of civil sunset, when the sun’s center is 6° below the horizon.
    ///
    /// The sky is often colored
    /// orange or red, and objects are typically distinguishable. Beyond civil dusk, artificial light may be
    /// needed for outdoor activities, depending on weather conditions. This property is optional because
    /// it's possible for the sun to not set on a given day, at extreme latitudes.
    public var civilDusk: Date?

    /// The time of nautical sunset, when the sun’s center is 12° below the horizon.
    ///
    /// This property is
    /// optional because it's possible for the sun to not set on a given day, at extreme latitudes. At nautical
    /// dusk, most stars become visible, and in clear weather conditions the horizon is visible.
    public var nauticalDusk: Date?

    /// The time of astronomical sunset, when the sun’s center is 18° below the horizon.
    ///
    /// The sun no
    /// longer illuminates the sky, and does not interfere with astronomical observations. This property is
    /// optional because it's possible for the sun to not set on a given day, at extreme latitudes.
    public var astronomicalDusk: Date?

    /// Represents solar midnight, the time when the sun reaches its lowest point in the sky.
    ///
    /// It may or
    /// may not be above the horizon at this time due to variations of solar events at extreme latitudes.
    /// If the lowest point is not below the horizon, this property is ``nil``.
    public var solarMidnight: Date?
}

extension SunEvents: Codable {}
extension SunEvents: Equatable {}
