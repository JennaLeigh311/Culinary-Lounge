//
//  RecipeApp.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI
import Combine


// This marks the entry point of my app

// Sources:
// https://developer.apple.com/documentation/security/storing-keys-in-the-keychain
// https://developer.apple.com/documentation/swiftui/stateobject
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
// make constants to ensure these are registered before the app runs


@main
struct RecipeApp: App {
    // State object is meant for keeping the same instance alive even after view re-renders
    // Without it, if the view refreshed it would create a new view model, resetting all the data
    // For the authViewModel we definitely want the entire app to know that the user is logged in for the whole session
    @StateObject var user = User()
    @StateObject var authViewModel: AuthViewModel
    @StateObject var usersViewModel: UsersViewModel
    @StateObject var recipesViewModel: RecipesViewModel
    @StateObject var filtersViewModel: FiltersViewModel

    init() {
        let user = User()
        _user = StateObject(wrappedValue: user)
        // SwiftUI ensures that the following initialization uses the
        // closure only once during the lifetime of the view, so
        // later changes to the view's name input have no effect.
        let auth = AuthViewModel(user: user)
        let recipes = RecipesViewModel()
        
        _authViewModel = StateObject(wrappedValue: auth)
        _recipesViewModel = StateObject(wrappedValue: recipes)
        _usersViewModel = StateObject(wrappedValue: UsersViewModel(auth: auth))
        _filtersViewModel = StateObject(wrappedValue: FiltersViewModel(recipes: recipes))
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
            .onChange(of: authViewModel.signInState, perform: { state in
                if state == .success {
                    usersViewModel.fetchLikes()
                    usersViewModel.fetchRecipes()
                    recipesViewModel.fetchRecipes()
                }
            })
            
        }
    }
}
