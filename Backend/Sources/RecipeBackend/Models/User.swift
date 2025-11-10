//
//  User.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent


// unchecked Sendable is there to fix an error that appeared when I wrote var id: UUID?, which I don't think should be a constant variable but it was giving an error that the variable was mutable, which is apparently some new Swift thing, and the people on StackOverflow were suggesting marking the class as unchecked Sendable, which I don't understand what it does except for telling Swift not to check for things that aren't supposed to be there and basically saying "Swift, trust me, there is nothing suspicious going on here"

// There was a ToDo model in this folder by default given as an example but I deleted it and can't get it back now to reference it, but I basically got this from it
final class User: Authenticatable, Model, Content, @unchecked Sendable {
    static let schema = "users"

    @ID(key: .id) // .id is the standard special key that resolves to an appropriate key for the underlying database driver ("id" for SQL and "_id" for NoSQL)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "email")
    var email: String

    @Field(key: "password") // should hash this later but rn we'll be wild
    var password: String
    
    @Field(key: "created_at")
    var created_at: Date

    init() { } // according to the documentation, all models must have an empty initializer

    init(id: UUID? = nil, username: String, email: String, password: String, created_at: Date = Date()) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
        self.created_at = created_at
    }
}
