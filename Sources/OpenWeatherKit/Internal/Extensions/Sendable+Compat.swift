//
//  Sendable+Compat.swift
//  
//
//  Created by Jeremy Greenwood on 11/24/22.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension Date: @unchecked Sendable {}
extension Measurement: @unchecked Sendable {}
extension URL: @unchecked Sendable {}
extension UnitAngle: @unchecked Sendable {}
extension UnitLength: @unchecked Sendable {}
extension UnitPressure: @unchecked Sendable {}
extension UnitSpeed: @unchecked Sendable {}
extension UnitTemperature: @unchecked Sendable {}

#if !os(Linux)
extension URLSession: @unchecked Sendable {}
#endif
