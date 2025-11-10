//
//  CreateLikeMigration.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Fluent

struct CreateLikeMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("likes")
            .id() // optional; you can remove if using composite PK instead
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("recipe_id", .uuid, .required, .references("recipes", "id"))
            .field("date", .datetime, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("likes").delete()
    }
}
