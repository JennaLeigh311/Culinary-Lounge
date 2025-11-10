//
//  CreateLikeDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Vapor
import Fluent

// This will represent data coming from the frontend
struct CreateLikeDTO: Content {
    var recipe_id: UUID
    var user_id: UUID

    func toModel() -> Like {
        Like(user_id: user_id, recipe_id: recipe_id) // don't need to pass in date because it's initialized by default
    }
}
