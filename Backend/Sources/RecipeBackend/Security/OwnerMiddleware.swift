//
//  OwnerMiddleware.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/15/25.
//

// SOURCE CODE: GENERATE BY CHATGPT

import Vapor
import JWT

struct OwnerMiddleware: AsyncMiddleware {
    let resourceOwnerIDKey: String // parameter name, e.g., "userID", "recipeID"

    func respond(to req: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        let payload = try req.auth.require(UserPayload.self)
        guard let resourceID = req.parameters.get(resourceOwnerIDKey) else {
            throw Abort(.badRequest)
        }

        if payload.aud.value.contains("admin") || payload.sub.value == resourceID {
            return try await next.respond(to: req)
        } else {
            throw Abort(.forbidden, reason: "You don't own this resource")
        }
    }
}
