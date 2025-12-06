//
//  SingInPage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

// Sources:
// https://stackoverflow.com/questions/76459947/how-can-you-add-clickable-text-in-a-swiftui-text-view
// https://medium.com/@jpmtech/swiftui-text-input-f9cae9eaca48
// https://stackoverflow.com/questions/69002594/can-i-somehow-convert-bindingstring-to-string
// https://stackoverflow.com/questions/64340992/swiftui-texteditor-disable-autocapitalization

import SwiftUI
import SwiftData

// defines what authentication state the app is in, and is used by AuthViewModel
enum SignInState {
    case notAttempted
    case success
    case failed
}

// this is not strictly necessary, but it makes it easier for me to encapsulate the credentials into one entity inside my view
struct Credentials {
    var email: String = ""
    var password: String = ""
}


// this view will only be displayed if the user is not logged in
struct SignInView: View {
    @State var creds: Credentials = Credentials()
    @EnvironmentObject var authViewModel: AuthViewModel
    @FocusState private var focusedField: Field?

     private enum Field: Int, Hashable {
       case email, password
     }
    
    var body: some View {
        VStack(spacing: 16) {
            
            // check the sign in state
            // if user signs in successfully, navigate to home screen - that will happen automatically
            
            // if the user fails, they probably input the wrong credentials
            if authViewModel.signInState == .failed {
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
                    
                    // then, when the user presses the button the authViewModel will be called with these credentials to initiate login
                    Button("Sign In") {
                        Task { authViewModel.login(email: creds.email, password: creds.password) }
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(18)
                    
                    // option to sign up if they don't have an account
                    HStack {
                        Text("or")
                        NavigationLink("sign up") {
                            
                            SignUpView()
                                .environmentObject(authViewModel)
                        }
                    }
                }
                // This is what appears if the credentials are wrong
                Text("Wrong credentials, try again")
                    .font(.caption)
                    .foregroundColor(.red)
            }
            // this is the default view, and I think in the future I should functionalize this better, but I ran into some issues while trying to functionalize this
            if authViewModel.signInState == .notAttempted {
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
                                .environmentObject(authViewModel)
                        }
                    }
                }
            }
        }
        .padding()
        .textInputAutocapitalization(.never) // this is because iOS has auto-caps on by default in text fields
        .disableAutocorrection(true)
    }
}
