//
//  RecipeCard.swift
//  recipeapp
//
//  RecipeCard.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//
import SwiftUI

// I'm thinking about my Reipe pages and how I want them to have a specific structure
// So Im thinking of using a struct for that called struct Content
// And using that struct along with a View to style different parts of the content in different ways

struct RecipeCardView: View {
    let recipe: Recipe // argument being passed in when the view is called
    
    var body: some View{

        VStack() {
            
            Text(recipe.title)
                .font(.headline)
            Text("Description: \(recipe.description)")
                .font(.subheadline)
            
        }
        .padding()
        .frame(maxWidth: 300, minHeight: 200)
        .background(Color.orange.opacity(0.3))
        .cornerRadius(12)
    }
}
