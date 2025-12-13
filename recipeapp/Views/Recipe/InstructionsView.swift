//
//  InstructionsView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//


import SwiftUI

// this is what the recipe article will contain to see the instructions
struct InstructionsView: View {
    let recipe: RecipeDTO
    
    var body: some View {
        ScrollView {
            Text(recipe.instructions)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Instructions")
        .background(Color(.systemGroupedBackground))
    }
}
