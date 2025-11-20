////
////  RecipeBottomMenuView.swift
////  recipeapp
////
////  Created by Jenna Bunescu on 11/19/25.
////
//
//import SwiftUI
//
//
//struct RecipeBottomMenuView: View {
//
//    var body: some View{
//        HStack (spacing: 20){
//            // check what's the status of the signInState
//                // If user is signed in, don't display the sign in button and instead display the liked recipes view
//                // Navigation link allows a user to tap on a UI component to access a new view - must be inside a NavigationStack (which is in my RecipeApp wrapping everything inside it)
//            NavigationLink(destination: IngredientsView()) {
//                Image(systemName: "house.fill")
//                // styling
//                    .font(.system(size: 28))
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: 80)
//                    .background(Color.orange.opacity(0.8))
//                    .foregroundColor(.white)
//                    .cornerRadius(18)
//                    .navigationBarBackButtonHidden(true)
//                
//            }
//                
//                NavigationLink(destination: InstructionsView()) {
//                    Image(systemName: "heart.circle.fill")
//                        .font(.system(size: 28))
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: 80)
//                        .background(Color.orange.opacity(0.8))
//                        .foregroundColor(.white)
//                        .cornerRadius(18)
//                        .navigationBarBackButtonHidden(true)
//                    
//                }
//                
//                NavigationLink(destination: RecipeContentView()) {
//                    Image(systemName: "person.crop.circle.badge.plus")
//                        .font(.system(size: 28))
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: 80)
//                        .background(Color.orange.opacity(0.8))
//                        .foregroundColor(.white)
//                        .cornerRadius(18)
//                }
//
//                
//            }
//            
//
//        }
//    }
//        
//}
