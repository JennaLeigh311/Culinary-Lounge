//
//  UserDTO.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/15/25.
//

import SwiftUI
import Foundation

struct UserDTO: Codable, Identifiable {
    var ID: UUID { id }
    var id: UUID = UUID() // default values are used so I can initialize an empty user struct in my user view model [FOR TESTING]
    var username: String = ""
    var email: String = ""
    var role: String = ""
    var created_at: Date = Date()
}
