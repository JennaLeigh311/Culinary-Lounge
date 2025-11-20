//
//  RecipeApp.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI
import Combine



// This marks the entry point of my app


// make constants to ensure these are registered before the app runs
let (users, recipes) = registerDummyData()

@main
struct RecipeApp: App {
    // State object is meant for keeping the same instance alive even after view re-renders
    // Without it, if the view refreshed it would create a new view model, resetting all the data
    // For the signInViewModel we definitely want the entire app to know that the user is logged in for the whole session
    // This is a private variable so that only RecipeApp can access it
    
    // I want this to apply to all the views for now because there are some issues with not doing that (having to do with live filtering of recipes)

    @StateObject private var signInViewModel = SignInTempViewModel(allUsers: users)
    @StateObject private var filtersViewModel = FiltersViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BottomMenuView()

            }
            .environmentObject(signInViewModel) // declares that my sign in view model is an environment object that can be used for all the views inside
            .environmentObject(filtersViewModel)
        }
    }
}
