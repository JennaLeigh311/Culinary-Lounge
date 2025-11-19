import Fluent
import Vapor


func routes(_ app: Application) throws {
    let protected = app.grouped(JWTMiddleware())
    
    app.get { req async in
        "It works!"
    }
    
    let userController = UserController()
    try app.register(collection: userController)
    
    let recipeController = RecipeController()
    try app.register(collection: recipeController)

    let commentController = CommentController()
    try app.register(collection: commentController)

    let likeController = LikeController()
    try app.register(collection: likeController)
    
    
}
