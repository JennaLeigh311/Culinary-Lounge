//
//  CreateCommentDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Vapor
import Fluent

// This will represent data coming from the frontend
struct CreateCommentDTO: Content {
    var recipe_id: UUID
    var author_id: UUID
    var content: String

    func toModel() -> Comment {
        Comment(author_id: author_id, recipe_id: recipe_id, content: content)
    }
}
