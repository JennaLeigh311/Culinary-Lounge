//
//  RecipeDTO.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/15/25.
//

import Foundation
import SwiftUI

// this is the recipe data transfer object
// it will be passed in from the APIs and decoded in the app to see recipes
// it will also be passed into the create recipe API
struct RecipeDTO: Codable, Identifiable {
    var ID: UUID { id! }
    var id: UUID? = nil
    var title: String = ""
    var author_id: String = ""
    var description: String = ""
    var cook_time_minutes: Int = 0
    var servings: Float = 0
    var cuisine_tag: String = ""
    var type_tag: String = ""
    var ingredients: String = ""
    var instructions: String = ""
    var content: String = ""
    var date_posted: Date = Date()
}
