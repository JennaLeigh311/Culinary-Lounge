//
//  RecipeDTO.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/15/25.
//

import Foundation
import SwiftUI


struct RecipeDTO: Codable, Identifiable {
    var ID: UUID { id }
    let id: UUID
    let title: String
    let author_id: String
    let description: String
    let cook_time_minutes: Int
    let servings: Float
    let cuisine_tag: String
    let type_tag: String
    let instructions: String
    let content: String
    let date_posted: Date
}
