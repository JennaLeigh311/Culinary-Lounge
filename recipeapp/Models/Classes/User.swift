//
//  User.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/28/25.
//


import Foundation

class User {
    let id: UUID // unchangeable
    var role: Roles
    var username: String
    var email: String
    var password: String
    
    var posts: [Post]
    var likes: [Like]
    var comments: [Comment]

    init(role: Roles, username: String, email: String, password: String) {
        self.id = UUID()
        self.role = role
        self.username = username
        self.email = email
        self.password = password
        self.posts = [] // default empty
        self.likes = [] // default zero - I think this is what I'll use in my "saved recipes" page
        self.comments = [] //default zero
    }
    // setters
    func changeUsername(newUsername: String) { self.username = newUsername }

    func changePassword(newPassword: String) { self.password = newPassword }

    func changeEmail(newEmail: String) { self.email = newEmail }
    
    // only an admin can change role but I'll need to implement that later
    func changeRole(newRole: Roles) { self.role = newRole }

    // getters
    func getUsername() -> String { return username }
    
    func getEmail() -> String { return email }
    
    func getRole() -> Roles { return role }
    
    func getPosts() -> [Post] { return posts }
    
    func getLikes() -> [Like] { return likes }
    
    func getComments() -> [Comment] { return comments }

//     make a new recipe post (pass in everything needed for the constructor)
//     the user will actually have to fill out a form when making this which will connect to this
    func make_post( title: String,
                   ingredients: [String],
                   description: String,
                   cookTime: Int,
                   servings: Int,
                   typeTags: Set<TypeTags>,
                   cuisineTags: Set<CuisineTags> ) -> Recipe {
        
        // create new recipe
        let newPost = Recipe(author: self,
                            title: title,
                            ingredients: ingredients,
                            description: description,
                            cookTime: cookTime,
                            servings: servings,
                            typeTags: typeTags,
                            cuisineTags: cuisineTags)
        posts.append(newPost) // add new post to list
        return newPost // return the post so that the user can see it right away
    }

    // Like a post - array implementation but this should become a set in the future
    func add_like(to postToLike: Recipe) {
        // Check if this user already liked the post will be implemented later
        let like = Like(author: self, post: postToLike) // call "like" constructor
        likes.append(like) // append to user's list
        postToLike.likes.append(like) // append to recipe's list of likes
    }

    // Comment on a post - same logic as likes
    func add_comment(to postToComment: Recipe, content: String) {
        let comment = Comment(author: self, post: postToComment, content: content)
        comments.append(comment)
        postToComment.comments.append(comment)
    }

}
