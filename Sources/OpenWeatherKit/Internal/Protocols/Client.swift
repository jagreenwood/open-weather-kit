//
//  Client.swift
//  
//
//  Created by Jeremy Greenwood on 11/9/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
#endif

protocol Client {
#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse
#else
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
#endif
}

#if os(Linux)
extension HTTPClient: Client {
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {
        try await execute(request, deadline: timeout, logger: nil)
    }
}
#else
extension URLSession: Client {}
#endif
