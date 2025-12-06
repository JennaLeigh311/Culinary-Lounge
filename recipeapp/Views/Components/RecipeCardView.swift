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

struct RecipeCardView: View {
    let recipe: RecipeDTO // argument being passed in when the view is called
    
    var body: some View{

        VStack() {
            // TO DO: render the image of the recipe
            
            Text(recipe.title)
                .font(.headline)
            Text("Description: \(recipe.description)")
                .font(.subheadline)
            
            
        }.foregroundColor(.black)
        .padding()
        .frame(maxWidth: 300, minHeight: 200)
        .background(Color.pink.opacity(0.3))
        .cornerRadius(12)
    }
}
