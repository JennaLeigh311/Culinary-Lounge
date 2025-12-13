//
//  RecipeContentsView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//


import SwiftUI

// this is what the recipe article will contain to see the content of the recipe, aka the "story"
struct RecipeContentsView: View {
    let recipe: RecipeDTO
    
    var body: some View {
        ScrollView {
            Text(recipe.content)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Content")
        .background(Color(.systemGroupedBackground))
    }
}
