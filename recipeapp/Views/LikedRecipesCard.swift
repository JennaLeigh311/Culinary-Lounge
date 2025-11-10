//
//  Untitled.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/14/25.
//

import SwiftUI

struct LikedRecipeCardView: View {
    let recipe: Meal // argument being passed in when the view is called
    
    var body: some View{

        VStack() {
            
            Text(recipe.strMeal)
                .font(.headline)
            Text(recipe.strCategory ?? "Unknown category")
                .font(.subheadline)
            
        }
        .padding()
        .frame(maxWidth: 300, minHeight: 200)
        .background(Color.orange.opacity(0.3))
        .cornerRadius(12)
    }
}
