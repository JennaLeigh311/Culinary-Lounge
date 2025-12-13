//
//  LikedRecipesView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// https://medium.com/@ramdhas/task-vs-onappear-78cda282342d

// this view displays which recipes the user has liked so that they have easy access to their favorite recipes
struct LikedRecipesView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel // needed to pass recipes
    @EnvironmentObject var usersViewModel: UsersViewModel // needed to use fetching function
    @EnvironmentObject var authViewModel: AuthViewModel // needed to pass user data to this view
    
    var body: some View{
        VStack (spacing: 15){
            // display user name
            Text(authViewModel.user.username + "'s liked recipes")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            // search bar to search for specific recipes
            SearchBar(text: .constant(""))
                .padding(.horizontal)
                .padding(.top, 30)
            
            // you should be able to also filter your own liked recipes
            // in the future when I implement filtering properly, I think all I really need to do is pass into this view model the list/array of recipeDTOs that I need to filter and write some functions for that
            FiltersView()
            
            // scrolls through your recipes - this could be functionalized as it uses the same code as in home page
            ScrollView {
                LazyVStack (spacing: 15){
                    // render recipe cards
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
