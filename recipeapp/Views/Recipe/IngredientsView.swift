//
//  IngredientsView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//

import SwiftUI

// this is what the recipe article will contain to see the ingredients
struct IngredientsView: View {
    let recipe: RecipeDTO
    
    var body: some View {
        ScrollView {
            Text(recipe.ingredients)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Ingredients")
        .background(Color(.systemGroupedBackground))
    }
}
