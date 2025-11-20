//
//  MenuBar.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI
import os

let logger = Logger(subsystem: "com.jenna.recipeapp", category: "network")

// This view will be the interface between the user and all of our main pages.
// This menu will in the future (NOW!) be different based on whether the user is logged in or not
// I actually have an idea how to do this and I think it's easy so I'll just do it now
struct BottomMenuView: View {
    // We need access to this viewModel which holds the signInState
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var creds: AuthCredsViewModel
    
    var body: some View{
        TabView {
            // check what's the status of the signInState
            if authViewModel.signInState == .success {
                // If user is signed in, don't display the sign in button and instead display the liked recipes view
                // Navigation link allows a user to tap on a UI component to access a new view - must be inside a NavigationStack (which is in my RecipeApp wrapping everything inside it)
                HomeView() .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                LikedRecipesView() .tabItem {
                    Label("Likes", systemImage: "heart.circle.fill")
                }
                
                // when the user either hasn't attempted sign in or failed their attempt
            } else {
                
                HomeView() .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                SignInView() .tabItem {
                    Label("Sign In", systemImage: "person.crop.circle.badge.plus")
                }.environmentObject(authViewModel)
                    .environmentObject(creds)
                
                
            }
        }
    }
}
        

