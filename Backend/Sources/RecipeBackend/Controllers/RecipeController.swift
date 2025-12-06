//  RecipeController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

struct RecipeController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let recipes = routes.grouped("recipes")
        let userProtected = recipes.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["user","admin"]))
        let adminProtected = recipes.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["admin"]))
        
        recipes.get(use: self.index) // GET /recipes -> list all recipes [PUBLIC]

        userProtected.post(use: self.create) // POST /recipes -> create a new recipe [USER OR ADMIN]
        
        recipes.group(":recipeID") { recipe in
            
            recipe.get(use: getOne)    // GET /recipes/:recipeID -> get a single recipe [PUBLIC]
            recipe.get("likes", "count", use: getLikeCount) // GET /recipes/:recipeID/likes/count -> get like count [PUBLIC]
            recipe.get("comments", "count", use: getCommentCount) // GET /recipes/:recipeID/comments/count -> get comment count [PUBLIC]
        }
        
        // I might need an API that gives me all the comment IDs
        
        recipes.group(":recipeID") { recipe in
            
            userProtected.delete(use: delete) // DELETE /recipe/:recipeID -> deletes a recipe [USER who owns the recipe]
        }
        
        recipes.get("filter", "cuisine", ":cuisineTag", use: getAllCuisineTag) // GET /recipes/filter/cuisine/:cuisineTag -> gives all the recipes with a certain cuisine_tag [PUBLIC]
        recipes.get("filter", "type", ":typeTag", use: getAllTypeTag) // GET /recipes/filter/type/:typeTag -> gives all the recipes with a certain type_tag [PUBLIC]
    }
    
    // handler to list all recipes
    @Sendable
    func index(req: Request) async throws -> [RecipeDTO] {
        let recipes = try await Recipe.query(on: req.db).all()
        return recipes.map { RecipeDTO(from: $0) }
    }
    
    // handler to create a new recipe
    @Sendable
    func create(req: Request) async throws -> RecipeDTO {
        let input = try req.content.decode(CreateRecipeDTO.self)
        let recipe = input.toModel()
        try await recipe.save(on: req.db)
        return RecipeDTO(from: recipe)
    }
    
    // handler to get one recipe
    @Sendable
    func getOne(req: Request) async throws -> RecipeDTO {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return RecipeDTO(from: recipe)
    }

    // handler to delete a recipe
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await recipe.delete(on: req.db)
        return .noContent
    }
    
    @Sendable
    func getLikeCount(req: Request) async throws -> Int {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let count = try await Like.query(on: req.db)
            .filter(\Like.$recipe.$id == recipe.id!)
            .count()
        return count
    }
    
    @Sendable
    func getCommentCount(req: Request) async throws -> Int {
        guard let recipe = try await Recipe.find(req.parameters.get("recipeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let count = try await Comment.query(on: req.db)
            .filter(\Comment.$recipe.$id == recipe.id!)
            .count()
        return count
    }
    
    // handler that returns all the recipes matching the cuisine tag
    @Sendable
    func getAllCuisineTag(req: Request) async throws -> [RecipeDTO] {
        // getting the cuisine tag from the parameters just like we did above in recipe id but we're not finding it in the database yet
        guard let cuisine_tag = req.parameters.get("cuisineTag") else {
            throw Abort(.notFound)
        }

        // filter used indexed column that I just set up
        let recipes = try await Recipe.query(on: req.db)
            .filter(\Recipe.$cuisine_tag == cuisine_tag) // by the way the $ gives a reference to the field of cuisine_tag not an actual value
            .all()

        return recipes.map { RecipeDTO(from: $0) } // it's going to be a list so map it
    }
    
    // handler that returns all the recipes matching the cuisine tag
    @Sendable
    func getAllTypeTag(req: Request) async throws -> [RecipeDTO] {
        // getting the cuisine tag from the parameters just like we did above in recipe id but we're not finding it in the database yet
        guard let type_tag = req.parameters.get("typeTag") else {
            throw Abort(.notFound)
        }

        // filter used indexed column that I just set up
        let recipes = try await Recipe.query(on: req.db)
            .filter(\Recipe.$type_tag == type_tag) // by the way the $ gives a reference to the field of cuisine_tag not an actual value
            .all()

        return recipes.map { RecipeDTO(from: $0) } // it's going to be a list so map it. the $0 kind of tells the function to iterate through the recipes starting from the first recipe in the list
    }
}
