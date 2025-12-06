//
//  LikedRecipesView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// temporary view
// the only difference is the icon for now

// https://medium.com/@ramdhas/task-vs-onappear-78cda282342d

struct LikedRecipesView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var authViewModel: AuthViewModel // needed to pass user data to this view
    
    var body: some View{
        VStack (spacing: 15){
            Text(authViewModel.user.username + "'s liked recipes")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 20)
            SearchBar(text: .constant(""))
                .padding(.horizontal)
                .padding(.top, 30)
            
            FiltersView()
            
            ScrollView {
                LazyVStack (spacing: 15){

                    ForEach(usersViewModel.user_likes) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe)) {
                            RecipeCardView(recipe: recipe)
                        }
                    }

                }
            }
        }
        .background(Color.white)
    }
}
