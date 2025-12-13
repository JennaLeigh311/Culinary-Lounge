//
//  CommentController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

// https://docs.vapor.codes/basics/controllers/
// this was also made from the default controller temaplate

struct CommentController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let comments = routes.grouped("comments")
        let userProtected = comments.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["user","admin"]))
        let adminProtected = comments.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["admin"]))

        adminProtected.get(use: self.index) // GET /comments -> list all comments [ADMIN]
        userProtected.post(use: self.create) // POST /comments -> create a new comment [USER OR ADMIN]
        comments.group(":commentID") { comment in
            
            userProtected.delete(use: delete) // DELETE /comments/:commentID -> delete a comment [NEEDS TO BE USER OR ADMIN -> IF USER, COMMENT NEEDS TO BELONG TO USER]
            comment.get(use: getOne)    // GET /comments/:commentID -> get a single comment [PUBLIC]
        }
    }

    // function to get all comments
    @Sendable
    func index(req: Request) async throws -> [CommentDTO] {
        let comments = try await Comment.query(on: req.db).all()
        return comments.map { CommentDTO(from: $0) } // map the comments into a list
    }

    // handler to create a new comment
    @Sendable
    func create(req: Request) async throws -> CommentDTO {
        // decode the input which is a create comment dto
        let input = try req.content.decode(CreateCommentDTO.self)
        // transfer to a comment dto using .toModel()
        let comment = input.toModel()
        // save in database
        try await comment.save(on: req.db)
        // return the new comment
        return CommentDTO(from: comment)
    }
    
    // handler to get one comment based on the comment id
    @Sendable
    func getOne(req: Request) async throws -> CommentDTO {
        // if you can find it in the database
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        //return it
        return CommentDTO(from: comment)
    }

    // handler to delete comment based on comment id
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        // if you can find it in the database
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        // delete it
        try await comment.delete(on: req.db)
        return .noContent
    }
}
