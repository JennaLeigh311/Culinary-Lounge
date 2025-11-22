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

@main
struct RecipeApp: App {
    // State object is meant for keeping the same instance alive even after view re-renders
    // Without it, if the view refreshed it would create a new view model, resetting all the data
    // For the signInViewModel we definitely want the entire app to know that the user is logged in for the whole session
    // This is a private variable so that only RecipeApp can access it
    
    // I want this to apply to all the views for now because there are some issues with not doing that (having to do with live filtering of recipes)
    // https://developer.apple.com/documentation/swiftui/stateobject
    @StateObject var user = User()

    @StateObject var authViewModel: AuthViewModel
    @StateObject var usersViewModel: UsersViewModel
    @StateObject var recipesViewModel = RecipesViewModel()
    @StateObject var filtersViewModel = FiltersViewModel()

    init() {
        let user = User()
        _user = StateObject(wrappedValue: user)
        // SwiftUI ensures that the following initialization uses the
        // closure only once during the lifetime of the view, so
        // later changes to the view's name input have no effect.
        _authViewModel = StateObject(wrappedValue: AuthViewModel(user: user))
        _usersViewModel = StateObject(wrappedValue: UsersViewModel(user: user))
    }


    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BottomMenuView()
                    
               
            }
            .environmentObject(filtersViewModel)
            .environmentObject(authViewModel)
            .environmentObject(usersViewModel)
            .environmentObject(recipesViewModel)
            .environmentObject(user)
            
        }
    }
}
