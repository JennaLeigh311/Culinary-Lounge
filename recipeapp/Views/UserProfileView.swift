//
//  UserProfileView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/21/25.
//


import SwiftUI

// temporary view
// the only difference is the icon for now

struct UserProfileView: View {
    @EnvironmentObject var signInViewModel: SignInTempViewModel
    @StateObject private var recipesViewModel = RecipesViewModel()
    @StateObject private var usersViewModel = UsersViewModel()
    
    var body: some View{
        VStack (spacing: 15){
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
        .background(Color.pink.opacity(0.3)) // also different background color just to make it more clear that they're different in the demo
        
        .onAppear { // onAppear will cause problems

            usersViewModel.user_likes = [] // clear any old data
            usersViewModel.fetchLikes()
        }
    }
}
