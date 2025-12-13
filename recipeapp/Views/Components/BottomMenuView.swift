//
//  MenuBar.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

// https://www.hackingwithswift.com/quick-start/swiftui/adding-tabview-and-tabitem

import SwiftUI
import os // I forgot what this import was for but i dont think i use it anymore

// This view will be the interface between the user and all of our main pages.
// This menu will is different based on whether the user is logged in or not
struct BottomMenuView: View {
    
    // all of these view models are environmental objects that need to be passed into our other pages
    @EnvironmentObject var authViewModel: AuthViewModel // We need access to this viewModel which holds the signInState
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @EnvironmentObject var usersViewModel: UsersViewModel
    
    
    var body: some View{
        // using tab view instead of Navigation links to fix the problem of new views being created infinitely (talked to Scott about this in like the first few LMs)
        TabView {
            // check what's the status of the signInState
            if authViewModel.signInState == .success {
                // If user is signed in, don't display the sign in button and instead display the liked recipes view
                
                HomeView() .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                LikedRecipesView() .tabItem {
                    Label("Likes", systemImage: "heart.circle.fill")
                }
                UserProfileView() .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                
                // when the user either hasn't attempted sign in or failed their attempt
            } else {
                
                HomeView() .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                SignInView() .tabItem {
                    Label("Sign In", systemImage: "person.crop.circle.badge.plus")
                }
                
                
            }
        }
        .environmentObject(authViewModel)
        .environmentObject(recipesViewModel)
        .environmentObject(usersViewModel)
    }
}
        

