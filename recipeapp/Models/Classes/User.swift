//
//  UserDTO.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/15/25.
//

import SwiftUI
import Foundation

class User: ObservableObject, Identifiable {
    var ID: UUID { id }
    @Published var id: UUID = UUID()
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var role: String = ""
    @Published var token: String = ""
    
}
