//
//  CommentsDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Fluent
import Vapor

struct CommentDTO: Content {
    var id: UUID?
    var recipe_id: UUID
    var author_id: UUID
    var content: String
    var date_posted: Date?
    
    init(from comment: Comment) {
        self.id = comment.id
        self.recipe_id = comment.$recipe.id
        self.author_id = comment.$author.id
        self.content = comment.content
        self.date_posted = comment.date_posted
    }
}
