//
//  JWTMiddleware.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/15/25.
//

// SOURCE CODE: GENERATE BY CHATGPT

import Vapor
import JWT

struct JWTMiddleware: AsyncMiddleware {
    func respond(to req: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard let bearer = req.headers.bearerAuthorization else {
            throw Abort(.unauthorized, reason: "Missing Bearer token")
        }

        do {
            let payload = try req.jwt.verify(bearer.token, as: UserPayload.self)
            req.auth.login(payload) // store payload for route access
            return try await next.respond(to: req)
        } catch {
            throw Abort(.unauthorized, reason: "Invalid token: \(error)")
        }
    }
}

