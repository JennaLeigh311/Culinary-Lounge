//
//  UserDTO.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/15/25.
//

import SwiftUI
import Foundation

// this is the User data transfer object
// I made it obervable because I needed the entire app to see what happens to this object
// this user object will be decoded from incoming API responses once the user logs in
class User: ObservableObject, Identifiable {
    var ID: UUID { id }
    @Published var id: UUID = UUID()
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var role: String = ""
    @Published var token: String = ""
    
}
