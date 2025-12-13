//
//  LikesDTO.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/29/25.
//

// https://www.baeldung.com/java-dto-pattern

import Fluent
import Vapor

// data transfer object of like
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

