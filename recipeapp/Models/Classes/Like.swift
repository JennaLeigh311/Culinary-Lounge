//
//  Like.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/28/25.
//

import Foundation


class Like {
    let author: User
    let date: Date
    let post: Post

    // Constructor - called by Post add_like()
    init(author: User, post: Post) {
        self.author = author
        self.post = post
        self.date = Date()
    }
    
    // Will have to implement destructor later on I guess
}
