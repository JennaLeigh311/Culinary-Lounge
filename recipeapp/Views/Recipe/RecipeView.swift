//
//  RecipeArticle.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//

import SwiftUI

// the actual recipe article
struct RecipeView: View {
    let recipe: RecipeDTO // argument being passed in when the view is called
    
    // Ingredients go first
    // Instructions go second
    // Story that no one reads goes third
    var body: some View{

        VStack() {
            
            Text(recipe.title)
                .font(.headline)
            Text("Description: \(recipe.description)")
                .font(.subheadline)
            
            
        }.padding()
            .background(.white)
        
        RecipeBottomMenuView(recipe: recipe)
        
    }
}

