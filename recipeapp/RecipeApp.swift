//
//  RecipeApp.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI
import Combine

// This marks the entry point of my app
@main
struct RecipeApp: App {
    // State object is meant for keeping the same instance alive even after view re-renders
    // Without it, if the view refreshed it would create a new view model, resetting all the data
    // For the signInViewModel we definitely want the entire app to know that the user is logged in for the whole session
    // This is a private variable so that only RecipeApp can access it
    @StateObject private var signInViewModel = SignInTempViewModel(allUsers: users)
    // Scene ?
    var body: some Scene {
        // Window group?
        WindowGroup {
            NavigationStack {
                HomeView()
                // declares that my sign in view model is an environment object that can be used for all the views inside HomeView (this should be changed later to a RootView)
                   
            }
            .environmentObject(signInViewModel)
        }
    }
}
