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
        // SOURCE CHATGPT
//        let adminProtected = users.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["admin"]))
//        let userProtected = users.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["user","admin"]))
//        
        users.get(use: self.index) // GET /users -> list all users [ADMIN]
        users.post(use: self.create) // POST /users -> create a new user [PUBLIC but access is controlled by frontend]
        users.group(":userID") { user in
            user.delete(use: delete) // DELETE /users/:userID -> delete a user [ADMIN OR USER IF DELETING OWN ACCOUNT]
            user.get(use: getOne) // GET /users/:userID -> get a single user [PUBLIC]
            user.get("recipes", "count", use: getRecipeCount) // GET /users/:userID/recipes/count -> get number of recipes posted by this user [PUBLIC]
            user.get("likes", "count", use: getLikeCount) // GET /users/:userID/likes/count -> get number of likes given by this user [USER OR ADMIN]
//            ownerProtected.get("likes", use: getLikes) // GET /users/:userID/likes -> get all liked recipes of user [USER OR ADMIN]
            user.get("likes", use: getLikes) // GET /users/:userID/likes -> get all liked recipes of user [USER OR ADMIN]
            user.get("recipes", use: getRecipes) // GET /users/:userID/recipes -> get all recipes posted by user [USER OR ADMIN]
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
    
    // handler to get the number of liked recipes
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
    
    // handler to get all liked recipes
    @Sendable
    func getLikes(req: Request) async throws -> [RecipeDTO] {
//        // console log for error testing
//        req.logger.info("=== getLikes() called ===")
//            req.logger.info("URL: \(req.url.string)")
//            req.logger.info("Method: \(req.method)")
//            req.logger.info("Headers: \(req.headers)")
        
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            req.logger.error("User not found for ID: \(req.parameters.get("userID") ?? "nil")")
            throw Abort(.notFound)
        }
        
//        // debugging
//        req.logger.info("User found, username: \(user.username), role from DB: \(user.role)")
//        
        
        // query database for likes
        let likes = try await Like.query(on: req.db)
            .filter(\Like.$user.$id == user.id!) // where the user id of the like == user id
            .with(\.$recipe) // preventing this error: fatalError("Parent relation not eager loaded, use $ prefix to access: \(self.name)")
            .all() // select * from likes
        
        let recipes = likes.map{ RecipeDTO(from: $0.recipe) } // map results to return array
        return recipes
    }
    
    // handler to get all the recipes posted by the user
    @Sendable
    func getRecipes(req: Request) async throws -> [RecipeDTO] {
//        // console log for error testing
//        req.logger.info("=== getRecipes() called ===")
//            req.logger.info("URL: \(req.url.string)")
//            req.logger.info("Method: \(req.method)")
//            req.logger.info("Headers: \(req.headers)")
//
        // find the user by id
        guard let user = try await User.find(req.parameters.get("userID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        // query database for all posted recipes
        let posted_recipes = try await Recipe.query(on: req.db)
            .filter(\Recipe.$author.$id == user.id!) // where author id == user id
            .all()
        
        // map the results to the return array
        let recipes = posted_recipes.map{ RecipeDTO(from: $0) }
        return recipes
    }
    
    
}
