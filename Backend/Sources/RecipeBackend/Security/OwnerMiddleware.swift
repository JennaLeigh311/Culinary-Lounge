//
//  OwnerMiddleware.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/15/25.
//

// SOURCE CODE: GENERATE BY CHATGPT

import Vapor
import JWT

// checks whether user owns the thing being accessed or user is admin
struct OwnerMiddleware: AsyncMiddleware {
    let resourceOwnerIDKey: String // parameter name passed in

    func respond(to req: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        let payload = try req.auth.require(UserPayload.self) // gets the payload
        guard let resourceID = req.parameters.get(resourceOwnerIDKey) else { // this is actually wrong right now, but I'm keeping the code here
            throw Abort(.badRequest)
        }

        // right now the problem with this is that it assumes that sub.value is an ID, which is what :commendID or :likeID or :recipeID are,
        if payload.aud.value.contains("admin") || payload.sub.value == resourceID {
            return try await next.respond(to: req)
        } else {
            throw Abort(.forbidden, reason: "You don't own this resource")
        }
    }
}
