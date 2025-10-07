//
//  HomePage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View{
        VStack (spacing: 15){
            TopBarView()
            FiltersView()
            // a scrollable view
            ScrollView {
                // in the future I need to have some logic for this to choose which ones to show (based on tags)
                // and also iterate through them automatically not manually
                LazyVStack (spacing: 15){
                    // ForEach(recipeViewModel.allRecipes, \.self) { recipe in RecipeCardView(recipe: recipe) }
                    RecipeCardView(recipe: recipe1)
                    RecipeCardView(recipe: recipe2)
                    RecipeCardView(recipe: recipe1)
                    RecipeCardView(recipe: recipe2)
                    RecipeCardView(recipe: recipe1)
                    RecipeCardView(recipe: recipe2)
                }
            }
            BottomMenuView()
        }
    }
}
