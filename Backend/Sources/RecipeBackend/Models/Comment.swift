//
//  Comment.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

final class Comment: Model, Content, @unchecked Sendable {
    static let schema = "comments"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "author_id")
    var author: User

    @Parent(key: "recipe_id")
    var recipe: Recipe

    @Field(key: "content")
    var content: String

    @Field(key: "date_posted")
    var date_posted: Date

    init() {}

    init(id: UUID? = nil, author_id: UUID, recipe_id: UUID, content: String, date_posted: Date = Date()) {
        self.id = id
        self.$author.id = author_id
        self.$recipe.id = recipe_id
        self.content = content
        self.date_posted = date_posted
    }
}
