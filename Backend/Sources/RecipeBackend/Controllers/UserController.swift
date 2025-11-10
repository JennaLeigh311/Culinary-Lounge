//
//  UserController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

// controller to handle routes fpr user
struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let users = routes.grouped("users")

        users.get(use: self.index) // GET /users -> list all users
        users.post(use: self.create) // POST /users -> create a new user
        users.group(":userID") { user in
            user.delete(use: delete) // DELETE /users/:userID -> delete a user
            user.get(use: getOne) // GET /users/:userID -> get a single user
            user.get("recipes", "count", use: getRecipeCount) // GET /users/:userID/recipes/count -> get number of recipes posted by this user
            user.get("likes", "count", use: getLikeCount) // GET /users/:userID/likes/count -> get number of likes given by this user
            user.get("likes", use: getLikes) // GET /users/:userID/likes -> get all liked recipes of user
            user.get("recipes", use: getRecipes) // GET /users/:userID/likes/count -> get all recipes posted by user
        }
    }

    // handler methods

    // handler to list all users
    @Sendable
    func index(req: Request) async throws -> [UserDTO] {
        let users = try await User.query(on: req.db).all() // fetch all users from the database
        return users.map { UserDTO(from: $0) } // convert to DTOs
        
    }

    // handler to create a new user
    @Sendable
    func create(req: Request) async throws -> UserDTO {
        let input = try req.content.decode(CreateUserDTO.self) // decode input data (from JSON format I think )
        let user = input.toModel() // convert to User model
        try await user.save(on: req.db) // save to database
        return UserDTO(from: user) // return the created user as a DTO
    }
    
    // handler to get a single user by ID
    @Sendable
    func getOne(req: Request) async throws -> UserDTO {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else { // find user by ID
            throw Abort(.notFound) // if user not found, throw 404 error
        }
        return UserDTO(from: user) // return the found user as a DTO
    }


    // handler to delete a user by ID
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        // find user by ID
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        // delete the user
        try await user.delete(on: req.db)
        return .noContent // return 204 No Content status
    }

    // handler to get the count of posted recipes 
    @Sendable
    func getRecipeCount(req: Request) async throws -> Int {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let count = try await Recipe.query(on: req.db)
            .filter(\Recipe.$author.$id == user.id!) // filter based on author id/user id
            .count() // gives count as an int
        return count
    }
    
    @Sendable
    func getLikeCount(req: Request) async throws -> Int {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let count = try await Like.query(on: req.db)
            .filter(\Like.$user.$id == user.id!)
            .count()
        return count
    }
    
    @Sendable
    func getLikes(req: Request) async throws -> [RecipeDTO] {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let likes = try await Like.query(on: req.db)
            .filter(\Like.$user.$id == user.id!)
            .with(\.$recipe) // preventing this error: fatalError("Parent relation not eager loaded, use $ prefix to access: \(self.name)")
            .all()
        
        let recipes = likes.map{ RecipeDTO(from: $0.recipe) } // 
        return recipes
    }
    
    @Sendable
    func getRecipes(req: Request) async throws -> [RecipeDTO] {
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        let likes = try await Recipe.query(on: req.db)
            .filter(\Recipe.$author.$id == user.id!)
            .all()
        
        let recipes = likes.map{ RecipeDTO(from: $0) }
        return recipes
    }
    
    
}
