import Fluent
import Vapor


func routes(_ app: Application) throws {
    let protected = app.grouped(JWTMiddleware())
    
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    let userController = UserController()
    try app.register(collection: userController)
    
    let recipeController = RecipeController()
    try app.register(collection: recipeController)

    let commentController = CommentController()
    try app.register(collection: commentController)

    let likeController = LikeController()
    try app.register(collection: likeController)

    app.get("number", ":x") { req -> String in
        guard let int = req.parameters.get("x", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return "\(int) is a great number"
    }

    app.get("hello", "**") { req -> String in
        let name = req.parameters.getCatchall().joined(separator: " ")
        return "Hello, \(name)!"
    }
    
    
}
