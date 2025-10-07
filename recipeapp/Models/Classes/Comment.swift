//
//  Comment.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/28/25.
//

import Foundation

// a post can have a comment
class Comment {
    let author: User // unchangeable
    let datePosted: Date
    let post: Post
    var content: String // placeholder
    // in the future I might implement a comment being able to have people comment on it and like it
    
    init(author: User, post: Post, content: String) {
        self.author = author
        self.post = post
        self.content = content
        self.datePosted = Date()
    }
    
    // change content - only variable thing
    func editComment(newContent: String) {
        self.content = newContent
    }
    
    // getters
    func getAuthor() -> User { return author }
        
    func getDatePosted() -> Date { return datePosted }
        
    func getPost() -> Post { return post }
        
    func getContent() -> String { return content }

}
