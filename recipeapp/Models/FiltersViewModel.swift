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
    }
    
    func select(cuisine: CuisineTags) {
        selectedCuisineTag = cuisine
        showCuisinesList = false
    }
    
}
