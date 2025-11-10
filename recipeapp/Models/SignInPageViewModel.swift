//
//  SignInPageViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// hey shouldn't I be doing this inside of my Vapor backend instead? I'm guessing this should actually only send http requests to an API and get the authentication state
@MainActor
final class SignInPageViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var loggedInUser: User?
    @Published var password: String = ""
    @Published var signInState: SignInState = .notAttempted
    
    let baseURL = "http://localhost:8080/users"

    // function that checks if email is correct
    
    // function that checks if password is correct
    
    func signIn() async {
        loggedInUser = nil
        signInState = .notAttempted

        
        guard let url = URL(string: "\(baseURL)/login") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["email": email, "password": password]
        request.httpBody = try? JSONEncoder().encode(body)

        do {
            let (_, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                signInState = .success
            } else {
                signInState = .failed
            }
        } catch {
            signInState = .failed
        }

    }

    
    
    
}
