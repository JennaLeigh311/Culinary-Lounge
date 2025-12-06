//
//  CreateUserDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/21/25.
//

import Vapor;
import Fluent;

// This will represent data coming from the frontend
struct CreateUserDTO: Content {
    var username: String
    var email: String
    var password: String
    var role: Role

    func toModel() -> User {
        User(username: username, email: email, password: password, role: role)
    }
}
