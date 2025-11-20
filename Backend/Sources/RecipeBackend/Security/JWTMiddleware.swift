//
//  JWTMiddleware.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/15/25.
//

// SOURCE CODE: GENERATE BY CHATGPT

import Vapor
import JWT

// checks for token in the request, verifies it, and stores the decoded payload for use in routes
struct JWTMiddleware: AsyncMiddleware {
    
    func respond(to req: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let bearer = req.headers.bearerAuthorization else { // check if it exists
            throw Abort(.unauthorized, reason: "Missing Bearer token")
        }

        do {
            // get payload and verify it
            let payload = try req.jwt.verify(bearer.token, as: UserPayload.self)
            req.auth.login(payload) // store payload for route access
            return try await next.respond(to: req) // allow access (or allow the authorization steps to continue if other middleware need to be gone through)
        } catch {
            throw Abort(.unauthorized, reason: "Invalid token: \(error)")
        }
    }
}

