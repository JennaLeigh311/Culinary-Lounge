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
    @EnvironmentObject var signInViewModel: SignInTempViewModel
    @StateObject private var recipesViewModel = RecipesViewModel()
    @StateObject private var usersViewModel = UsersViewModel()
    
    var body: some View{
        VStack (spacing: 15){
            TopBarView()
            FiltersView()
            ScrollView {
                LazyVStack (spacing: 15){
                    
                    ForEach(usersViewModel.user_likes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }

                }
            }
            BottomMenuView()
        }
        .background(Color.pink.opacity(0.3)) // also different background color just to make it more clear that they're different in the demo
        .onAppear {

            usersViewModel.user_likes = [] // clear any old data
            usersViewModel.fetchLikes()
        }
    }
}
