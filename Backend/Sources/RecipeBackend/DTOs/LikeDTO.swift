//
//  LikesDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

import Fluent
import Vapor

struct LikeDTO: Content {
    var recipe_id: UUID
    var user_id: UUID
    var date: Date
    
    init(from like: Like) {
        self.recipe_id = like.$recipe.id
        self.user_id = like.$user.id
        self.date = like.date
    }
}

