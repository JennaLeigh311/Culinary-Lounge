//
//  SignUpView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI
import SwiftData

// keep track of state of sign up
enum SignUpState {
    case notAttempted
    case success
    case failed
}

// view to sign up / create user
struct SignUpView: View {
    // this is all very similar to sign in view so it's uncommented
    
    @EnvironmentObject var authViewModel: AuthViewModel // will use the sign up function
    @State var creds = Credentials()
    @FocusState private var focusedField: Field?

     private enum Field: Int, Hashable {
       case email, password
     }

    var body: some View {
        // Sign-up form
        VStack(spacing: 16) {

            TextField("Email", text: $creds.email)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.secondary.opacity(1), lineWidth: 1)
                )
            
            // whatever the user types will be bound to the password string
            SecureField("Password", text: $creds.password)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.secondary.opacity(1), lineWidth: 1)
                )
            
            Button("Sign Up") { // call the signup function
                Task { authViewModel.signup(email: creds.email, password: creds.password) }
                // TO DO: if signup state is success, log the person in immediately
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(18)
        }
        .padding()
        .textInputAutocapitalization(.never) // this is because iOS has auto-caps on by default in text fields
        .disableAutocorrection(true)
    }
}
    
