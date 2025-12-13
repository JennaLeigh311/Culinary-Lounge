//
//  UserDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/21/25.
//

import Fluent
import Vapor

// data transfer object of user
struct UserDTO: Content {
    var id: UUID?
    var username: String
    var email: String
    var role: Role
    var created_at: Date
    
    // password shouldn't come out to the frontend
    
    init(from user: User) {
        self.id = user.id
        self.username = user.username
        self.email = user.email
        self.role = user.role
        self.created_at = user.created_at
        
    }
}
