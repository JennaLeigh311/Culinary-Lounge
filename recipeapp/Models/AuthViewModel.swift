//
//  AuthViewModel.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/18/25.
//

import Foundation
import SwiftUI

// This is the View model that handles the logic of authentication
// It is observable so that other views can see what the state of authentication is in the app
class AuthViewModel: ObservableObject {
    @Published var user: User // we'll need to get the user details from the APIs
    @Published var signInState: SignInState = .notAttempted // intially starting at not attempted
    @Published var signUpState: SignUpState = .notAttempted

    // when the view model is first intiated, it will also intiate one user object. this is why it's important to make sure this view model is only initiated once.
    init(user: User) {
        self.user = user
    }
    
    // Function to log in
    func login(email: String, password: String) {
        // make sure that if this function is called it's always when the sign In state is not attempted
        signInState = .notAttempted
        
        // checks if the parameters are valid
        if email == "" || password == "" {
            print("Empty data fields")
            return
        }
        
        // sets the url of the API
        let url = URL(string: "http://127.0.0.1:9090/login")!
        
        // this specifies what type of request this is
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // for the Go program - it expects a creds object like this
        let creds: [String: String] = [
            "email": email,
            "password": password
        ]
        
        // encode creds into json
        request.httpBody = try? JSONEncoder().encode(creds)
        
        // start task
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            // if there's an error fetching the user data
            if let error = error {
                print("Error while fetching data:", error)
                self.signInState = .failed // change state
                return
            }
            print("RAW RESPONSE:")
            print(String(data: data!, encoding: .utf8)!)
            
            // if there is no UserDTO object coming out of the API (raw response), that means there is no user registered under those credentials
            guard let data = data else {
                self.signInState = .failed // change state
                return
            }
            
            // if the raw response is not empty, make a log in response which will then map to the User object in this view model
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
                
                // decode incoming data
                let decodedData = try decoder.decode(LoginResponse.self, from: data)
                
                // Assigning the data to the login response
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    self.user.id = decodedData.id
                    self.user.username = decodedData.username
                    self.user.email = decodedData.email
                    self.user.role = decodedData.role
                    self.user.token = decodedData.token
                    self.signInState = .success
                }
                
            } catch let jsonError { // if failed to decode
                print("Failed to decode json", jsonError)
                DispatchQueue.main.async { self.signInState = .failed }
            }
        }
        
        task.resume()

    }
    
    // function to sign up, however this function is still a work in progress right now, so I will leave it here like this but it's not worth looking into
    func signup(email: String, password: String) {
        signUpState = .notAttempted
        
        let url = URL(string: "http://127.0.0.1:9090/users")!
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
                var id: UUID?
                var username: String
                var email: String
                var created_at: Date
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedData = try decoder.decode(SignupResponse.self, from: data)
                // Assigning the data to the array
                DispatchQueue.main.async { // When the data is ready, go back to the main thread, and update the UI safely.
                    print(decodedData)
                    self.signUpState = .success
                    
                }
                
            } catch let jsonError {
                DispatchQueue.main.async { self.signUpState = .failed }
                print("Failed to decode json", jsonError)
            }
        }
        
        task.resume()
        
        
    }
    
}
