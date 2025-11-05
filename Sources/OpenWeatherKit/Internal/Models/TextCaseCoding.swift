//
//  TextCaseCoding.swift
//  open-weather-kit
//
//  Created by Jeremy Greenwood on 2/24/25.
//

import Foundation

@propertyWrapper
struct TextCaseCoding<Case: TextCase>: Codable, Sendable {
    var wrappedValue: Case.Value

    init(wrappedValue: Case.Value) {
        self.wrappedValue = wrappedValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(Case.transform(wrappedValue))
    }
}

// swiftlint:disable force_cast
extension KeyedDecodingContainer {
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

protocol TextCase {
    associatedtype Value: Codable, Sendable

    static var transform: @Sendable (Value) -> Value { get }
}

enum Lowercased: TextCase {
    static let transform: @Sendable (String) -> String = { $0.lowercased() }
}

enum Uppercased: TextCase {
    static let transform: @Sendable (String) -> String = { $0.uppercased() }
}

enum Capitalized: TextCase {
    static let transform: @Sendable (String) -> String = { $0.capitalized }
}

enum LowercasedOptional: TextCase {
    static let transform: @Sendable (String?) -> String? = { $0?.lowercased() }
}

enum UppercasedOptional: TextCase {
    static let transform: @Sendable (String?) -> String? = { $0?.uppercased() }
}

enum CapitalizedOptional: TextCase {
    static let transform: @Sendable (String?) -> String? = { $0?.capitalized }
}

enum LowercasedArray: TextCase {
    static let transform: @Sendable ([String]) -> [String] = { $0.map { $0.lowercased() } }
}

enum UppercasedArray: TextCase {
    static let transform: @Sendable ([String]) -> [String] = { $0.map { $0.uppercased() } }
}

enum CapitalizedArray: TextCase {
    static let transform: @Sendable ([String]) -> [String] = { $0.map(\.capitalized) }
}
