//
//  CreateCommentMigration.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Fluent

struct CreateCommentMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("comments")
            .id()
            .field("recipe_id", .uuid, .required, .references("recipes", "id"))
            .field("author_id", .uuid, .required, .references("users", "id"))
            .field("content", .string, .required)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("comments").delete()
    }
}
