//
//  AuthCredsViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//

import SwiftUI
import Foundation

class AuthCredsViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func reset() {
        email = ""
        password = ""
    }
}
