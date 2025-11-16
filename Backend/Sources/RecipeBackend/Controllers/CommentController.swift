//
//  CommentController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

struct CommentController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let comments = routes.grouped("comments")
        let publicProtected = comments.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["guest","user","admin"]))
        let userProtected = comments.grouped(JWTMiddleware(), RoleMiddleware(allowedRoles: ["user","admin"]))

        publicProtected.get(use: self.index) // GET /comments -> list all comments [PUBLIC]
        userProtected.post(use: self.create) // POST /comments -> create a new comment [NEEDS TO BE USER OR ADMIN]
        comments.group(":commentID") { comment in
            
            let ownerProtected = comment.grouped(JWTMiddleware(), OwnerMiddleware(resourceOwnerIDKey: "commentID"))
            ownerProtected.delete(use: delete) // DELETE /comments/:commentID -> delete a comment [NEEDS TO BE USER OR ADMIN -> IF USER, COMMENT NEEDS TO BELONG TO USER]
            publicProtected.get(use: getOne)    // GET /comments/:commentID -> get a single comment [PUBLIC]
        }
    }

    @Sendable
    func index(req: Request) async throws -> [CommentDTO] {
        let comments = try await Comment.query(on: req.db).all()
        return comments.map { CommentDTO(from: $0) }
    }

    @Sendable
    func create(req: Request) async throws -> CommentDTO {
        let input = try req.content.decode(CreateCommentDTO.self)
        let comment = input.toModel()
        try await comment.save(on: req.db)
        return CommentDTO(from: comment)
    }

    @Sendable
    func getOne(req: Request) async throws -> CommentDTO {
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return CommentDTO(from: comment)
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let comment = try await Comment.find(req.parameters.get("commentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await comment.delete(on: req.db)
        return .noContent
    }
}
