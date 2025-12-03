//
//  UserProfileView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/21/25.
//

// https://stackoverflow.com/questions/78626615/swiftui-full-width-button-why-maxwidth-infinity-why-not-minwidth-infini

import SwiftUI

// This view is the user profile page
// Currently, there are no APIs to fetch the user's stats, so those are temporarily statically configured in here
struct UserProfileView: View {
    
    @EnvironmentObject var recipesViewModel: RecipesViewModel // needed to post a new recipe
    @EnvironmentObject var usersViewModel: UsersViewModel // needed to fetch all user's posted recipes
    @EnvironmentObject var authViewModel: AuthViewModel // needed to pass user data to this view
    let heartImage = Image(systemName: "heart.fill") // static user profile icon
    
    var body: some View{
        // can scroll if the recipe list is long
        ScrollView {
            
            VStack (spacing: 15){
                
                VStack(spacing: 3) {
                    // username tag
                    Text("@\(authViewModel.user.username)")
                        .fontWeight(.semibold)
                        .padding(.top, 20)
                    
                    HStack{
                        // user profile icon
                        heartImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle()) // "trap" the image into a circle
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2)) // border
                        
                        Spacer() // push to occupy max horizontal space
                        HStack(spacing: 10) {
                            // number of posts
                            VStack {
                                Text("14")
                                Text("Posts")
                                    .fontWeight(.semibold)
                            }
                            // number of followers
                            VStack {
                                Text("100")
                                Text("Followers")
                                    .fontWeight(.semibold)
                            }
                            // number of people the user is following
                            VStack {
                                Text("89")
                                Text("Following")
                                    .fontWeight(.semibold)
                            }
                        }.padding(10)
                    }.padding(30)
                
                    // edit profile button - currently does not operate
                    Button(action: { print("record clicked") }) {
                        Text("Edit Profile")
                            .padding(10)
                    }.frame(maxWidth: .infinity, minHeight: 30)
                    .background(Color.gray)
                    .cornerRadius(4)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    
                    // button to post a recipe that calls the recipes view model
                    // changes to be made: link this to the fetchRecipes() function of the UsersViewModel
                    Button(action: { usersViewModel.postRecipe() }) {
                        Text("Post a Recipe")
                            .padding(10)
                    }.frame(maxWidth: .infinity, minHeight: 30)
                    .background(Color.gray)
                    .cornerRadius(4)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                    }
                
                
                        // TO DO: make a list of recipe names here
                    VStack(alignment: .leading, spacing: 10) {
                        if usersViewModel.user_recipes.isEmpty {
                            Text("No recipes yet.")
                                .foregroundColor(.secondary)
                                .padding(.top, 10)
                        } else {
                            ForEach(usersViewModel.user_recipes) { recipe in
                                HStack {
                                    Text(recipe.title)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: RecipeView(recipe: recipe)) {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                }
            }
        }
    }
