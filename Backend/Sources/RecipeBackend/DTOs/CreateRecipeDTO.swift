//
//  CreateRecipeDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Vapor
import Fluent

struct CreateRecipeDTO: Content {
    var author_id: UUID
    var title: String
    var description: String
    var cook_time_minutes: Int
    var servings: Float
    var cuisine_tag: String
    var type_tag: String
    var content: String
    var instructions: String

    func toModel() -> Recipe {
        Recipe(
            author_id: author_id,
            title: title,
            description: description,
            cook_time_minutes: cook_time_minutes,
            servings: servings,
            cuisine_tag: cuisine_tag,
            type_tag: type_tag,
            content: content,
            instructions: instructions
        )
    }
}
