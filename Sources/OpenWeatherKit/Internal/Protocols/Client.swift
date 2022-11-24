//
//  Client.swift
//  
//
//  Created by Jeremy Greenwood on 11/9/22.
//

import Foundation
#if os(Linux)
import AsyncHTTPClient
import NIOCore
#endif

protocol Client: Sendable {
#if os(Linux)
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse

    func shutdown() async throws
#else
    func data(_ request: URLRequest) async throws -> (Data, URLResponse)
#endif
}

#if os(Linux)
extension HTTPClient: Client {
    func execute(_ request: HTTPClientRequest, timeout: TimeAmount) async throws -> HTTPClientResponse {
        try await execute(request, timeout: timeout, logger: nil)
    }
}
#else
extension URLSession: Client {
    func data(_ request: URLRequest) async throws -> (Data, URLResponse) {
        if #available(iOS 15, *) {
            return try await data(for: request)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                let task = dataTask(with: request) { data, response, error in
                    guard let data = data, let response = response else {
                        let error = error ?? URLError(.badServerResponse)
                        return continuation.resume(throwing: error)
                    }

                    continuation.resume(returning: (data, response))
                }

                task.resume()
            }
        }
    }
}
#endif
