//
//  SingInPage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

// https://stackoverflow.com/questions/76459947/how-can-you-add-clickable-text-in-a-swiftui-text-view

// https://medium.com/@jpmtech/swiftui-text-input-f9cae9eaca48

import SwiftUI
import SwiftData
enum SignInState {
    case notAttempted
    case success
    case failed
}

struct SignInView: View {
    @EnvironmentObject var creds: AuthCredsViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // check the sign in state
            switch authViewModel.signInState {
            // if signed in, display welcome message
            // technically I'll just probably have this go to the home screen automatically right after the welcome message but for now it's fine
            case .success:
                if let user = authViewModel.user {
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
                    TextField("Email", text: $creds.email)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(.secondary.opacity(1), lineWidth: 1)
                        )
                    
                    SecureField("Password", text: $creds.password)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(.secondary.opacity(1), lineWidth: 1)
                        )
                    
                    Button("Sign In") {
                        Task { authViewModel.login(email: creds.email, password: creds.password) }
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(18)
                    
                    HStack {
                        Text("or")
                        NavigationLink("sign up") {
                            SignUpView()
                                .environmentObject(creds)
                                .environmentObject(authViewModel)
                        }
                    }
                }
            }
        }
        .padding()
        .autocapitalization(.none) // this is because iOS has auto-caps on by default in text fields
    }
}
