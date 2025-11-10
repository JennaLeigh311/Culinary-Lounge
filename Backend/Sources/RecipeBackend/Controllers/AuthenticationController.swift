//
//  AuthenticationController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/9/25.
//

import Vapor
import JWTKit

struct LoginRequest: Content {
    let username: String
    let password: String
}

struct TokenResponse: Content {
    let token: String
}

struct AuthenticationController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped("auth")
        auth.post("login", use: login)
        
        // other endpoints: register, refresh, etc
    }

    func login(req: Request) async throws -> TokenResponse {
        let login = try req.content.decode(LoginRequest.self)
        // Validate credentials (example pseudocode):
        guard let user = try await User.query(on: req.db)
            .filter(\.$username == login.username)
            .first(),
              user.verify(password: login.password)
        else {
            throw Abort(.unauthorized, reason: "Invalid credentials")
        }

        // Create payload
        let payload = UserPayload(
            subject: SubjectClaim(value: user.id!.uuidString),
            expiration: ExpirationClaim(value: .init(value: Date().addingTimeInterval(3600))),
            username: user.username,
            role: user.role
        )

        // Sign token
        let token = try req.jwt.sign(payload)
        return TokenResponse(token: token)
    }
}
