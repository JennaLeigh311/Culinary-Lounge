//
//  FetchRecipes.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/14/25.
//

// source: https://anjalijoshi2426.medium.com/fetch-and-display-api-data-on-list-using-swiftui-13fff61e8826

import Foundation
import SwiftUI

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Identifiable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
}


class MealViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchRemoteData(for mealName: String) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(mealName)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // optional
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
                let decodedData = try JSONDecoder().decode(MealResponse.self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    self.meals.append(contentsOf: decodedData.meals)
                }
            } catch let jsonError {
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
    }
}
