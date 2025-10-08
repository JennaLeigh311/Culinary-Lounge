//
//  SingInPage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI
import SwiftData
enum SignInState {
    case notAttempted
    case success
    case failed
}

struct SignInView: View {
    @EnvironmentObject var viewModel: SignInTempViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // check the sign in state
            switch viewModel.signInState {
            // if signed in, display welcome message
            // technically I'll just probably have this go to the home screen automatically right after the welcome message but for now it's fine
            case .success:
                if let user = viewModel.loggedInUser {
                    Text("Welcome \(user.username)!")
                        .font(.title)
                }
            case .failed:
                Text("Wrong credentials")
                    .font(.title)
            case .notAttempted:
                // Sign-in form
                VStack(spacing: 16) {
                    // now one thing I don't get is why not every area in the rectangle is clickable
                    TextField("Email", text: $viewModel.email)
                        .padding(10)
                        .background(Color(.white))
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding(10)
                        .background(Color(.white))
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    
                    Button("Sign In") {
                        Task { viewModel.signIn() }
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(18)
                }
            }
        }
        .padding()
        .autocapitalization(.none) // this is because iOS has auto-caps on by default in text fields
    }
}
