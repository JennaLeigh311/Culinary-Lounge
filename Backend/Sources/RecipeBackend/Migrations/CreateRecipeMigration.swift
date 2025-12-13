////
////  CreateRecipeMigration.swift
////  RecipeBackend
////
////  Created by Jenna Bunescu on 10/29/25.
////
//
//import Fluent
//
//struct CreateRecipeMigration: AsyncMigration {
//    func prepare(on database: any Database) async throws {
//        try await database.schema("recipes")
//            .id()
//            .field("author_id", .uuid, .required, .references("users", "id"))
//            .field("title", .string, .required)
//            .field("description", .string, .required)
//            .field("cook_time", .int, .required)
//            .field("servings", .int, .required)
//            .field("type_tag", .string)
//            .field("cuisine_tag", .string)
//            .field("content", .string, .required)
//            .field("ingredients", .string, .required)
//            .field("instructions", .string, .required)
//            .field("image_url", .string)
//            .field("date_posted", .datetime)
//            .create()
//    }
//
//    func revert(on database: any Database) async throws {
//        try await database.schema("recipes").delete()
//    }
//}
