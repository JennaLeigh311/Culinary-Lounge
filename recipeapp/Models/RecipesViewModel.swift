//
//  RecipesViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/18/25.
//

// source: https://anjalijoshi2426.medium.com/fetch-and-display-api-data-on-list-using-swiftui-13fff61e8826

import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    @Published var recipes: [RecipeDTO] = []
    
    // Get a recipe from all recipes list
    func fetchRecipe() {
        let url = URL(string: "http://127.0.0.1:8080/recipes")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode([RecipeDTO].self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    
                    self.recipes.append(contentsOf: decodedData)
                }
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
    
    func
    
    // post a new recipe
    
    
    // delete a recipe
    
    
    //
    
}
