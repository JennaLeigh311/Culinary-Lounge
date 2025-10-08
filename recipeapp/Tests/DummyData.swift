//
//  DummyData.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/7/25.
//

import SwiftUI

// Dummy data

func registerDummyData() -> ([User], [Recipe]) {
    let user1: User = .init(role: .USER, username: "jennaleigh", email: "jenna@example.com", password: "password")
    
    
    let user2: User = .init(role: .USER, username: "alexleonida", email: "alex@example.com", password: "password")
    
    
    let recipe1: Recipe = .init(
        author: user1,
        title: "Spaghetti Carbonara",
        ingredients: ["Spaghetti", "Guanciale or pancetta", "Egg yolks", "Grated Parmesan cheese", "Black pepper"],
        description: "GUANCIALE + American",
        cookTime: 12,
        servings: 24,
        typeTags: Set([.breakfast, .lunch]),
        cuisineTags: Set([.italian, .american])
    )
    
    
    let recipe2: Recipe = .init(
        author: user1,
        title: "Ramen Noodles",
        ingredients: ["Ramen Noodles", "Egg", "Beef", "Beef stock", "Greens"],
        description: "Asian + American",
        cookTime: 12,
        servings: 24,
        typeTags: Set([.lunch, .dinner]),
        cuisineTags: Set([.asian, .american])
    )
    
    let recipe3: Recipe = .init(
        author: user1,
        title: "American Noodles",
        ingredients: ["Ramen Noodles", "Egg", "Beef", "Beef stock", "Greens"],
        description: "American",
        cookTime: 12,
        servings: 24,
        typeTags: Set([.lunch]),
        cuisineTags: Set([.american])
    )
    
    let recipe4: Recipe = .init(
        author: user1,
        title: "Venison Loin Margarita",
        ingredients: ["Ramen Noodles", "Egg", "Beef", "Beef stock", "Greens"],
        description: "Italian + American",
        cookTime: 12,
        servings: 24,
        typeTags: Set([.lunch, .dinner]),
        cuisineTags: Set([.italian, .american])
    )
    
    
    let recipe5: Recipe = .init(
        author: user1,
        title: "Dumplings",
        ingredients: ["Ramen Noodles", "Egg", "Beef", "Beef stock", "Greens"],
        description: "Asian",
        cookTime: 12,
        servings: 24,
        typeTags: Set([.breakfast, .lunch, .dinner]),
        cuisineTags: Set([.asian])
    )
    
    
    let users: [User] = [user1, user2]
    let recipes: [Recipe] = [recipe1, recipe2, recipe3, recipe4, recipe5]
    
    return (users, recipes)
    
}
