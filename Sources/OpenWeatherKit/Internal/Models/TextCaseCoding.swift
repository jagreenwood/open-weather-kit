//
//  TextCaseCoding.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/24/25.
//

import Foundation

@propertyWrapper
public struct TextCaseCoding<Case: TextCase>: Codable, Sendable {
    public var wrappedValue: Case.Value

    public init(wrappedValue: Case.Value) {
        self.wrappedValue = wrappedValue
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Case.transform(wrappedValue))
    }
}

// swiftlint:disable force_cast
public extension KeyedDecodingContainer {
    func decode<Case: TextCase>(_ type: TextCaseCoding<Case>.Type, forKey key: Key) throws -> TextCaseCoding<Case> {
        if Case.Value.self is Optional<String>.Type {
            try TextCaseCoding(wrappedValue: Case.transform(decodeIfPresent(String.self, forKey: key) as! Case.Value))
        } else if Case.Value.self is String.Type {
            try TextCaseCoding(wrappedValue: Case.transform(decode(String.self, forKey: key) as! Case.Value))
        } else if Case.Value.self is Array<String>.Type {
            try TextCaseCoding(wrappedValue: Case.transform(decode([String].self, forKey: key) as! Case.Value))
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [key], debugDescription: "Not Implemented"))
        }
    }
}
// swiftlint:enable force_cast

extension TextCaseCoding: Equatable where Case.Value: Equatable { }
extension TextCaseCoding: Hashable where Case.Value: Hashable { }

public protocol TextCase {
    associatedtype Value: Codable, Sendable

    static var transform: @Sendable (Value) -> Value { get }
}

public enum Lowercased: TextCase {
    public static let transform: @Sendable (String) -> String = { $0.lowercased() }
}

public enum Uppercased: TextCase {
    public static let transform: @Sendable (String) -> String = { $0.uppercased() }
}

public enum Capitalized: TextCase {
    public static let transform: @Sendable (String) -> String = { $0.capitalized }
}

public enum LowercasedOptional: TextCase {
    public static let transform: @Sendable (String?) -> String? = { $0?.lowercased() }
}

public enum UppercasedOptional: TextCase {
    public static let transform: @Sendable (String?) -> String? = { $0?.uppercased() }
}

public enum CapitalizedOptional: TextCase {
    public static let transform: @Sendable (String?) -> String? = { $0?.capitalized }
}

public enum LowercasedArray: TextCase {
    public static let transform: @Sendable ([String]) -> [String] = { $0.map { $0.lowercased() } }
}

public enum UppercasedArray: TextCase {
    public static let transform: @Sendable ([String]) -> [String] = { $0.map { $0.uppercased() } }
}

public enum CapitalizedArray: TextCase {
    public static let transform: @Sendable ([String]) -> [String] = { $0.map(\.capitalized) }
}
