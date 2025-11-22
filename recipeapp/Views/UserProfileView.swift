//
//  UserProfileView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/21/25.
//

// https://stackoverflow.com/questions/78626615/swiftui-full-width-button-why-maxwidth-infinity-why-not-minwidth-infini

import SwiftUI

// temporary view
// the only difference is the icon for now

struct UserProfileView: View {
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    let heartImage = Image(systemName: "heart.fill")
    
    var body: some View{
        ScrollView {
            
            VStack (spacing: 15){
                VStack(spacing: 3) {
                    Text("@\(authViewModel.user.username)")
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    HStack{
                        heartImage
                            .frame(width: 50, height: 50)

                        Spacer()
                        HStack(spacing: 10) {
                            VStack {
                                Text("14")
                                Text("Posts")
                                    .fontWeight(.semibold)
                            }
                            VStack {
                                Text("100")
                                Text("Followers")
                                    .fontWeight(.semibold)
                            }
                            VStack {
                                Text("89")
                                Text("Following")
                                    .fontWeight(.semibold)
                            }
                        }.padding(10)
                    }.padding(30)
                
                    
                    Button(action: { print("record clicked") }) {
                        Text("Edit Profile")
                            .padding(10)
                    }.frame(maxWidth: .infinity, minHeight: 30)
                    .background(Color.gray)
                    .cornerRadius(4)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)

                    }
                }
            }
            
            .onAppear { // onAppear will cause problems
                
                usersViewModel.user_likes = [] // clear any old data
                usersViewModel.fetchLikes()
            }
        }
    }
