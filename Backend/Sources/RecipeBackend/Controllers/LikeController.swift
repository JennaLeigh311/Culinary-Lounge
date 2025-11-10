//
//  LikeController.swift
//  RecipeBackend
//
//  Created by Jenna Bunescu on 10/2/25.
//

import Vapor
import Fluent

struct LikeController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let likes = routes.grouped("likes")

        likes.get(use: self.index) // GET /likes -> list all likes
        likes.post(use: self.create) // POST /likes -> create a new like
        likes.group(":likeID") { like in
            like.delete(use: delete) // DELETE /likes/:likeID -> delete a like
            like.get(use: getOne)    // GET /likes/:likeID -> get a single like
        }
    }

    @Sendable
    func index(req: Request) async throws -> [LikeDTO] {
        let likes = try await Like.query(on: req.db).all()
        return likes.map { LikeDTO(from: $0) }
    }

    @Sendable
    func create(req: Request) async throws -> LikeDTO {
        let input = try req.content.decode(CreateLikeDTO.self)
        let like = input.toModel()
        try await like.save(on: req.db)
        return LikeDTO(from: like)
    }

    @Sendable
    func getOne(req: Request) async throws -> LikeDTO {
        guard let like = try await Like.find(req.parameters.get("likeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return LikeDTO(from: like)
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let like = try await Like.find(req.parameters.get("likeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await like.delete(on: req.db)
        return .noContent
    }
}
