//
//  RecipeBottomMenuView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//

import SwiftUI

struct RecipeBottomMenuView: View {
    
    var body: some View{
        TabView {
            
            IngredientsView() .tabItem {
                Label("Ingredients", systemImage: "house.fill")
            }
            InstructionsView() .tabItem {
                Label("Instructions", systemImage: "heart.circle.fill")
            }
            RecipeContentsView() .tabItem {
                Label("Content", systemImage: "heart.circle.fill")
            }
                
        }
    }
}
        

