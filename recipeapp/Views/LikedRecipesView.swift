//
//  LikedRecipesView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// temporary view
// the only difference is the icon for now

struct LikedRecipesView: View {
    var body: some View{
        VStack (spacing: 15){
            TopBarView()
            FiltersView()
            ScrollView {
                LazyVStack (spacing: 15){
//                    RecipeCardView(recipe: recipe1)
                
                }
            }
            BottomMenuView()
        }
        .background(Color.pink.opacity(0.3)) // also different background color just to make it more clear that they're different in the demo
    }
}
