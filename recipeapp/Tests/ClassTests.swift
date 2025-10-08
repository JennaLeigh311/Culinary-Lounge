//
//  ClassTests.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

// I'm hoping that in the future I can implement XCTest unit testing instead of these manual tests
// I'll try to do that next assignment if that's acceptable

import SwiftUI


func runUnitTests() {
    print("Unit tests:")
    
    // create 2 users
    let user1 = User(role: .USER, username: "jenna", email: "jenna@example.com", password: "password123")
    
    let user2 = User(role: .USER, username: "alex", email: "alex@example.com", password: "password456")
    
    print("Created users:")
    print("\(user1.getUsername()) with role \(user1.getRole())")
    print("\(user2.getUsername()) wit role \(user2.getRole())")
    
    print("")
    
    // jenna makes a recipe post
    let recipe1 = user1.make_post(title: "Pasta Carbonara",
                                ingredients: ["Pasta", "Eggs", "Parmesan", "Bacon"],
                                description: "Fast and easy when you don't have time to boil water",
                                cookTime: 20,
                                servings: 2,
                                typeTags: [.breakfast],
                                cuisineTags: [.italian])
    
    print("jenna made a post:")
    print("Title: \(recipe1.getTitle())")
    print("Author: \(recipe1.author.getUsername())")
    print("Description: \(recipe1.getDescription())")
    
    print("")
    
    // alex likes recipe
    user2.add_like(to: recipe1)
    print("After alex liked recipe:")
    print("Recipe like count: \(recipe1.likes.count)") // .count is apparently built into arrays so it's pretty efficient, so I don't actually need a like_count attribute like I thought I would
    print("alex like count: \(user2.getLikes().count)")
    
    print("")
    
    // jenna likes recipe
    user1.add_like(to: recipe1)
    print("After jenna liked recipe:")
    print("Recipe like count: \(recipe1.likes.count)") // .count is apparently built into arrays so it's pretty efficient, so I don't actually need a like_count attribute like I thought I would
    print("jennalike count: \(user1.getLikes().count)")
    
    print("")
    
    // alex adds comment
    user2.add_comment(to: recipe1, content: "nice!")
    print("After alex commented:")
    print("Recipe comment count: \(recipe1.comments.count)")
    print("alex comment count: \(user2.getComments().count)")
    
    print("")
    
    // alex adds another comment
    user2.add_comment(to: recipe1, content: "cool")
    print("After alex commented again:")
    print("Recipe comment count: \(recipe1.comments.count)")
    print("alex comment count: \(user2.getComments().count)")
    
    print("")
    
    // test setters of recipe
    recipe1.changeTitle(newTitle: "Spaghetti Carbonara")
    recipe1.changeCookingTime(newTime: 25)
    print("After editing recipe:")
    print("New title: \(recipe1.getTitle())")
    print("New cooking time: \(recipe1.getCookingTime()) minutes")
    
    print("")
    
    // test changing user info
    user1.changeUsername(newUsername: "jennaUpdated")
    user1.changeEmail(newEmail: "jennaNew@example.com")
    print("After editing jenna user:")
    print("New username: \(user1.getUsername())")
    print("New email: \(user1.getEmail())")
    
    print("")
    
}
