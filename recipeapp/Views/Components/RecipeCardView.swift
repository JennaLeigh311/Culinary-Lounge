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

// this is the pink card that previews the recipe and is seen in the home page view and likes page view
struct RecipeCardView: View {
    let recipe: RecipeDTO // argument being passed in when the view is called
    
    var body: some View{

        VStack() {
            // TODO: render the image of the recipe here
            Text(recipe.title)
                .font(.headline)
            Text("Description: \(recipe.description)")
                .font(.subheadline)
            
            
        }.foregroundColor(.black) // styling
        .padding()
        .frame(maxWidth: 300, minHeight: 200)
        .background(Color.pink.opacity(0.3))
        .cornerRadius(12)
    }
}
