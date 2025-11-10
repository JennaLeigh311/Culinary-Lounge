//
//  Like.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

final class Like: Model, Content, @unchecked Sendable {
    static let schema = "likes"

    @ID(key: .id) // this must be included here even if I don't have it in my database
    var id: UUID?

    @Parent(key: "user_id")
    var user: User

    @Parent(key: "recipe_id")
    var recipe: Recipe

    @Field(key: "date")
    var date: Date

    init() {}

    init(id: UUID? = nil, user_id: UUID, recipe_id: UUID, date: Date = Date()) {
        self.id = id
        self.$user.id = user_id
        self.$recipe.id = recipe_id
        self.date = date
    }
}
