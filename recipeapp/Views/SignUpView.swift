//
//  SignUpView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI
import SwiftData

enum SignUpState {
    case notAttempted
    case success
    case failed
}

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var creds = Credentials()

    var body: some View {
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
            
            Button("Sign Up") {
                Task { authViewModel.signup(email: creds.email, password: creds.password) }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(18)
        }
        .padding()
        .autocapitalization(.none)
    }
}
    
