//
//  AuthViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/18/25.
//


import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var user: User
    @Published var signInState: SignInState = .notAttempted
    @Published var signUpState: SignUpState = .notAttempted

    init(user: User) {
        self.user = user
    }
    
    // Get all likes from user
    func login(email: String, password: String) {
        
        signInState = .notAttempted
        if email == "" || password == "" {
            print("Empty data fields")
            return
        }
        
        let url = URL(string: "http://127.0.0.1:9090/login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // for the Go program
        let creds: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONEncoder().encode(creds)

        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                self.signInState = .failed
                return
            }
            print("RAW RESPONSE:")
            print(String(data: data!, encoding: .utf8)!)
            
            guard let data = data else {
                self.signInState = .failed
                return
            }
            
            struct LoginResponse: Codable {
                let token: String
                let id: UUID
                let username: String
                let email: String
                let role: String
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode(LoginResponse.self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    self.user.id = decodedData.id
                    self.user.username = decodedData.username
                    self.user.email = decodedData.email
                    self.user.role = decodedData.role
                    self.user.token = decodedData.token
                    self.signInState = .success
                }
                
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                DispatchQueue.main.async { self.signInState = .failed }
            }
        }
        
        task.resume()

        
    }
    
    
    func signup(email: String, password: String) {
        let url = URL(string: "http://127.0.0.1:9090/signup/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let creds: [String: String] = [
            "email": email,
            "password": password
        ]
        
        request.httpBody = try? JSONEncoder().encode(creds)

        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                self.signInState = .failed
                return
            }
            
            guard let data = data else {
                return
            }
            
            struct SignupResponse: Codable {
                let message: String
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode(SignupResponse.self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    print(decodedData)
                    
                }
                
            } catch let jsonError {
                self.signUpState = .failed
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
        self.signUpState = .success
        
        
    }
    
}
