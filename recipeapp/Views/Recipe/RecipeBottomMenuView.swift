//
//  RecipeBottomMenuView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//

import SwiftUI

// this is the component that helps us navigte between ingredients, instructions, and content
struct RecipeBottomMenuView: View {
    let recipe: RecipeDTO

    var body: some View {
        TabView {
            IngredientsView(recipe: recipe)
                .tabItem {
                    Label("Ingredients", systemImage: "list.bullet")
                }

            InstructionsView(recipe: recipe)
                .tabItem {
                    Label("Instructions", systemImage: "number")
                }

            RecipeContentsView(recipe: recipe)
                .tabItem {
                    Label("Content", systemImage: "book.fill")
                }
        }
    }
}
