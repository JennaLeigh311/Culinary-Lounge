//
//  UsersViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/18/25.
//

import Foundation
import SwiftUI

class UsersViewModel: ObservableObject {
    @Published var user_likes: [RecipeDTO] = []
    @Published var user_recipes: [RecipeDTO] = []
    
    private let auth: AuthViewModel

        init(auth: AuthViewModel) {
            self.auth = auth
        }
    
    // Get all likes from user
    func fetchLikes() {
        
        print("Fetching all liked recipes of user: \(auth.user.id), \(auth.user.username), \(auth.user.email), \(auth.user.role)")
        let url = URL(string: "http://127.0.0.1:8080/users/\(auth.user.id)/likes")!
        
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
                decoder.dateDecodingStrategy = .iso8601 // this was recommended by ChatGPT to fix and error with the JSON Date type not being the same as the Date type that Swift is looking for, so it decodes the json date to a swift date type
                
                let decodedData = try decoder.decode([RecipeDTO].self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    self.user_likes = decodedData
                }
                
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
    
    
    
    
    func fetchRecipes() {
        
        print("Fetching all recipes of user: \(auth.user.id), \(auth.user.username), \(auth.user.email), \(auth.user.role)")
        let url = URL(string: "http://127.0.0.1:8080/users/\(auth.user.id)/recipes")!
        
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
                decoder.dateDecodingStrategy = .iso8601 // this was recommended by ChatGPT to fix and error with the JSON Date type not being the same as the Date type that Swift is looking for, so it decodes the json date to a swift date type
                
                let decodedData = try decoder.decode([RecipeDTO].self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    self.user_recipes = decodedData
                }
                
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
    
    
    
    // post a new recipe
    func postRecipe() {
        
    }
    
    // delete a recipe
    
    
    //
    
}
