//
//  FiltersViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// It's good practice to make ViewModels "final" classes, so that they don't support any inheritance behavior. The compiler can optimize method calls because it knows this. I will change my other classes to be final as well.

// ObservableObject is a protocol that tells Swift it can 'watch' for changes, because this will be our ViewModel which handles View logic, so when the User interacts with the view this class will be the one handling logic and communicating with the View.
final class FiltersViewModel: ObservableObject {
    // Properties that can change under this protocol are marked with @Published
    @Published var selectedTypeTag: TypeTags = .dinner // defaults
    @Published var selectedCuisineTag: CuisineTags = .italian
    
    @Published var showTypesList = false
    @Published var showCuisinesList = false
    
    let availableTypeTags = TypeTags.allCases
    let availableCuisneTags = CuisineTags.allCases
    
    // where all the current selected recipes will go
    @Published var filteredRecipes: [Recipe] = []
    
    // make sure that filterRecipes() is called at initialization so that the initial view has a default list of recipe cards (otherwise it would be empty and render an empty recipe card page)
    init() {
        filterRecipes()
        print("Initial filteredRecipes: \(filteredRecipes.map { $0.title })") // printing for debugging
    }
    
    func toggleTypesList() {
        showTypesList.toggle()
        showCuisinesList = false // this is to automatically close the other dropdown
    }
    
    func toggleCuisinesList() {
        showCuisinesList.toggle()
        showTypesList = false
    }
    
    func select(type: TypeTags) {
        selectedTypeTag = type
        showTypesList = false
        filterRecipes()
    }
    
    func select(cuisine: CuisineTags) {
        selectedCuisineTag = cuisine
        showCuisinesList = false
        filterRecipes()
    }
    
    func filterRecipes() {
        // add the values at that key (or empty)
        let typeMatches = recipesByTypeTag[selectedTypeTag] ?? []
        let cuisineMatches = recipesByCuisineTag[selectedCuisineTag] ?? []
        
        let typeSet = Set(typeMatches) // sets are needed here so I can take the .intersection later because it doesn;t work on arrays
        let cuisineSet = Set(cuisineMatches)
        
        // debugging!
        print("Type matches (\(selectedTypeTag)): \(typeMatches.map { $0.title })")
        print("Cuisine matches (\(selectedCuisineTag)): \(cuisineMatches.map { $0.title })")
        
        // combine both sets using intersection (only want the recipes that match on both filters
        filteredRecipes = Array(typeSet.intersection(cuisineSet))
        print("Updated filteredRecipes: \(filteredRecipes.map { $0.title })") // debugging printing

        }
    
}
