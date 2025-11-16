//
//  VerifyToken.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/10/25.
//

import Vapor
import JWT

struct UserPayload: JWTPayload, Authenticatable {
    var sub: SubjectClaim  // email from Go token
    var iss: IssuerClaim   // issuer
    var aud: AudienceClaim  // role
    var exp: ExpirationClaim // expiration
    var iat: IssuedAtClaim // issued at

    func verify(using signer: JWTSigner) throws {
        try exp.verifyNotExpired()  // check expiration

        if iat.value > Date() {
            throw JWTError.claimVerificationFailure(
                name: "iat",
                reason: "Token issued in the future"
            )
        }
        
        guard iss.value == "Authentication" else {
            throw JWTError.claimVerificationFailure(name: "iss", reason: "Invalid issuer")
        }
        
        // Check audience (role) is valid
        let allowedRoles = ["user", "admin"]
        guard allowedRoles.contains(aud.value) else {
            throw JWTError.claimVerificationFailure(name: "aud", reason: "Invalid role")
        }

        // Optionally: check sub is a valid email format
        guard sub.value.contains("@") else {
            throw JWTError.claimVerificationFailure(name: "sub", reason: "Invalid email")
        }
        
    }
}
//
//// Example using a RouteProtector
//let protectedRoute = routes.grouped(User.authenticator(), User.guardMiddleware())
//protectedRoute.get("protected") { req async throws -> String in
//    let user = try req.auth.require(User.self)
//    return "Welcome, \(user.id)!"
//}
