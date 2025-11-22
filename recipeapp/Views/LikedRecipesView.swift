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
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View{
        VStack (spacing: 15){
            Text(authViewModel.user.username)
            SearchBar(text: .constant(""))
                .padding(.horizontal)
                .padding(.top, 30)
            FiltersView()
            ScrollView {
                LazyVStack (spacing: 15){

                    ForEach(usersViewModel.user_likes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }

                }
            }
        }
        .background(Color.white) // also different background color just to make it more clear that they're different in the demo
        
        .onAppear { // onAppear will cause problems
        
            usersViewModel.fetchLikes()
        }
    }
}
