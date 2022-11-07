//
//  EventLoopGroupProvider+Map.swift
//  
//
//  Created by Jeremy Greenwood on 11/7/22.
//

#if os(Linux)
import Foundation
import AsyncHTTPClient
import NIOCore

extension NIOEventLoopGroupProvider {
    var eventLoopGroupProvider: HTTPClient.EventLoopGroupProvider {
        switch self {
        case .shared(let eventLoopGroup): return .shared(eventLoopGroup)
        case .createNew: return .createNew
        }
    }
}
#endif
