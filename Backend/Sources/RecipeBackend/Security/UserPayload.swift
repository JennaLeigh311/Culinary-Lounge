//
//  UserPayload.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 11/9/25.
//

import JWTKit
import Vapor

// JWT payload structure
// Source: https://docs.vapor.codes/security/jwt/
struct UserPayload: JWTPayload {
    // Maps the longer Swift property names to the
    // shortened keys used in the JWT payload.
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case isAdmin = "admin"
    }

    // The "sub" (subject) claim identifies the principal that is the
    // subject of the JWT.
    var subject: SubjectClaim

    // The "exp" (expiration time) claim identifies the expiration time on
    // or after which the JWT MUST NOT be accepted for processing.
    var expiration: ExpirationClaim

    // Custom data.
    // If true, the user is an admin.
    var isAdmin: Bool

    // Run any additional verification logic beyond
    // signature verification here.
    // Since we have an ExpirationClaim, we will
    // call its verify method.
    func verify(using signer: JWTSigner) throws { // had to use ChatGPT to ask why it was giving my an error because this code is straight from the documentation so it told me to slightly change this function to not be async and also use JWTSigner instead of JWTAlgorithm, without that it doesn't conform to the JWTPayload protocol. I looked at this to confirm https://api.vapor.codes/jwtkit/documentation/jwtkit/jwtalgorithm. I'm a little confused but ok.
        try self.expiration.verifyNotExpired()
    }
    
    // I'm convinced that the documentation for both Vapor and JWTKit are outdated... I should've known that I should do my backend in a different language... LOL

}
