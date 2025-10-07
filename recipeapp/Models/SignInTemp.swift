//
//  SignInTemp.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// Temporary ViewModel for local testing (synchronous)
final class SignInTempViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var loggedInUser: User?
    @Published var password: String = ""
    @Published var signInState: SignInState = .notAttempted

    // Users already created statically in your app
    let users: [User]
    
    init(allUsers: [User]) {
        self.users = allUsers
    }

    func signIn() {
        // Reset previous state
        signInState = .notAttempted

        // Check if a user exists with matching email and password
        // This is a closure implementation
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            signInState = .success
            loggedInUser = user
        } else {
            signInState = .failed
        }
    }
}
