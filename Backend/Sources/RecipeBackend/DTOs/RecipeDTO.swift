//
//  RecipeDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//
import Fluent
import Vapor

struct RecipeDTO: Content {
    var id: UUID?
    var author_id: UUID
    var title: String
    var description: String
    var cook_time_minutes: Int
    var servings: Float
    var cuisine_tag: String
    var type_tag: String
    var content: String
    var instructions: String
    var date_posted: Date
    

    init(from recipe: Recipe) {
        self.id = recipe.id
        self.author_id = recipe.$author.id
        self.title = recipe.title
        self.description = recipe.description
        self.cook_time_minutes = recipe.cook_time_minutes
        self.servings = recipe.servings
        self.cuisine_tag = recipe.cuisine_tag
        self.type_tag = recipe.type_tag
        self.instructions = recipe.instructions
        self.content = recipe.content
        self.date_posted = recipe.date_posted
    }
}
