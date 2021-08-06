//
//  ParseLiveQuery+async.swift
//  ParseLiveQuery+async
//
//  Created by Corey Baker on 8/6/21.
//  Copyright © 2021 Parse Community. All rights reserved.
//

#if swift(>=5.5)
import Foundation

@available(macOS 12.0, iOS 15.0, macCatalyst 15.0, watchOS 9.0, tvOS 15.0, *)
extension ParseLiveQuery {
    // MARK: Async/Await

    /**
     Manually establish a connection to the `ParseLiveQuery` Server. Publishes when established.
      - parameter isUserWantsToConnect: Specifies if the user is calling this function. Defaults to `true`.
      - returns: A publisher that eventually produces a single value and then finishes or fails.
    */
    public func open(isUserWantsToConnect: Bool = true) async throws -> Result<Void, Error> {
        try await withCheckedThrowingContinuation { continuation in
            self.open(isUserWantsToConnect: isUserWantsToConnect) { error in
                guard let error = error else {
                    continuation.resume(returning: .success(()))
                    return
                }
                continuation.resume(returning: .failure(error))
            }
        }
    }

    /**
     Sends a ping frame from the client side. Publishes when a pong is received from the
     server endpoint.
     - returns: A publisher that eventually produces a single value and then finishes or fails.
    */
    public func sendPing() async throws -> Result<Void, Error> {
        try await withCheckedThrowingContinuation { continuation in
            self.sendPing { error in
                guard let error = error else {
                    continuation.resume(returning: .success(()))
                    return
                }
                continuation.resume(returning: .failure(error))
            }
        }
    }
}

#endif
