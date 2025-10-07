//
//  MenuBar.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI

// This view will be the interface between the user and all of our main pages.
// This menu will in the future (NOW!) be different based on whether the user is logged in or not
// I actually have an idea how to do this and I think it's easy so I'll just do it now
struct BottomMenuView: View {
    // We need access to this viewModel which holds the signInState
    @EnvironmentObject var viewModel: SignInTempViewModel
    
    var body: some View{
        HStack (spacing: 20){
            // check what's the status of the signInState
            switch viewModel.signInState {
                // If user is signed in, don't display the sign in button and instead display the liked recipes view
            case .success:
                // Navigation link allows a user to tap on a UI component to access a new view - must be inside a NavigationStack (which is in my RecipeApp wrapping everything inside it)
                NavigationLink(destination: HomeView()) {
                    Image(systemName: "house.fill")
                        // styling
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 80)
                        .background(Color.orange.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .navigationBarBackButtonHidden(true)
                    
                }
                
                NavigationLink(destination: LikedRecipesView()) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 80)
                        .background(Color.orange.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .navigationBarBackButtonHidden(true)
                    
                }
                
            // when the user either hasn't attempted sign in or failed their attempt
            default:
                NavigationLink(destination: HomeView()) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 80)
                        .background(Color.orange.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .navigationBarBackButtonHidden(true) // I added this when looking for the reason why navigating to HomePage when I'm already on HomePage re-renders it by default and treats it as a new page, and right now the temporary solution will be this, however the real solution should use TabViews apparently, but I'd have to look into that first.
                    
                }
                
                NavigationLink(destination: SignInView()) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 80)
                        .background(Color.orange.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(18)
                }

                
            }
            

        }
    }
        
}
