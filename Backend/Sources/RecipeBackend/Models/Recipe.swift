//
//  Recipe.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

// https://docs.vapor.codes/fluent/model/

final class Recipe: Model, Content, @unchecked Sendable{
    static let schema = "recipes" // table name in DB

    @ID(key: .id)
    var id: UUID?

    // Author is the "Parent" of this recipe
    @Parent(key: "author_id")
    var author: User

    // Fields
    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "cook_time_minutes")
    var cook_time_minutes: Int

    @Field(key: "servings")
    var servings: Float

    @Field(key: "type_tag")
    var type_tag: String
    
    @Field(key: "cuisine_tag")
    var cuisine_tag: String

    @Field(key: "content")
    var content: String
    
    @Field(key: "ingredients")
    var ingredients: String
    
    @Field(key: "instructions")
    var instructions: String
    
    @Field(key: "date_posted")
    var date_posted: Date

    // Default initializer for Fluent
    init() {}

    // Convenience initializer
    init(id: UUID? = nil,
         author_id: UUID,
         title: String,
         description: String,
         cook_time_minutes: Int,
         servings: Float,
         cuisine_tag: String,
         type_tag: String,
         content: String,
         instructions: String,
         ingredients: String
    ) {
        self.id = id
        self.$author.id = author_id
        self.title = title
        self.description = description
        self.cook_time_minutes = cook_time_minutes
        self.servings = servings
        self.cuisine_tag = cuisine_tag
        self.type_tag = type_tag
        self.content = content
        self.ingredients = ingredients
        self.instructions = instructions
        self.date_posted = Date()
    }
}
