//
//  Optional+Utils.swift
//  
//
//  Created by Jeremy Greenwood on 11/2/22.
//

@preconcurrency import Foundation

extension Optional {
    func unwrap(or error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let wrapped): return wrapped
        case .none: throw error()
        }
    }
}
