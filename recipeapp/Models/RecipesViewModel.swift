//
//  RecipesViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/18/25.
//

import Foundation
import SwiftUI

// this view model fetches recipes for the home screen
class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [RecipeDTO] = []
    init() {
        fetchRecipes()
    }
    
    // Get a recipe from all recipes list
    func fetchRecipes() {
        // set url to read from
        let url = URL(string: "http://127.0.0.1:8080/recipes")!
        
        // set request type
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // start task
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            // if there is an error
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            // make sure there is data being passed out of the api
            guard let data = data else {
                return // return if there is no data
            }
            
            do {
                // decode the data
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode([RecipeDTO].self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    
                    self.recipes = decodedData // add the list of recipes to what the user can see
                }
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
    
    
}
