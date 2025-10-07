//
//  Post.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/28/25.
//

import Foundation

// Post is a protocol just to give more free reign for how the other post types will behave like
protocol Post {
    var id: UUID { get }
    var datePosted: Date { get }
    var author: User { get }
    var likes: [Like] { get set }
    var comments: [Comment] { get set }
    var content: String { get set } // placeholder for now until I figure out what Content will be
}
