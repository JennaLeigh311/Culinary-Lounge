//
//  DummyData.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/7/25.
//

import SwiftUI

// Dummy data

let user1: User = .init(role: .USER, username: "jennaleigh", email: "jenna@example.com", password: "password")


let user2: User = .init(role: .USER, username: "alexleonida", email: "alex@example.com", password: "password")


let recipe1: Recipe = .init(
    author: user1,
    title: "Spaghetti Carbonara",
    ingredients: ["Spaghetti", "Guanciale or pancetta", "Egg yolks", "Grated Parmesan cheese", "Black pepper"],
    description: "GUANCIALE NYAM",
    cookTime: 12,
    servings: 24,
    tags: ["Italian", "Pasta"]
)

let recipe2: Recipe = .init(
    author: user1,
    title: "Ramen Noodles",
    ingredients: ["Ramen Noodles", "Egg", "Beef", "Beef stock", "Greens"],
    description: "JApan",
    cookTime: 12,
    servings: 24,
    tags: ["Japanese", "Noodles"]
)

let users: [User] = [user1, user2]
let recipes: [Recipe] = [recipe1, recipe2]

