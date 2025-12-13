//
//  CreateRecipeView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 12/2/25.
//

import SwiftUI

// https://medium.com/@jpmtech/swiftui-text-input-f9cae9eaca48
// https://developer.apple.com/documentation/swiftui/textfieldstyle
// https://www.avanderlee.com/swiftui/picker-styles-color/

let cuisineOptions = ["American", "Italian", "Mexican", "Asian", "French", "Indian"] // list of cuisine strings shown in picker
let typeOptions = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snack", "Side"] // list of type strings shown in picker

// the form that's seen when a user wants to create their own recipe
struct CreateRecipeView: View {
    @EnvironmentObject var usersViewModel: UsersViewModel // access shared user-related functions
    @EnvironmentObject var authViewModel: AuthViewModel // access authentication information
    @Environment(\.dismiss) var dismiss // allows closing the view

    @State private var recipe = RecipeDTO() // holds new recipe data being created
    @State private var showingAlert = false // controls showing alert
    @State private var alertMessage = "" // message for alert

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // title
                VStack(alignment: .leading) {
                    Text("Recipe Title")
                        .font(.headline)
                    TextField("Enter recipe title", text: $recipe.title) // user inputs recipe title
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // cook time and servings
                HStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Cook Time (min)")
                            .font(.headline)
                        TextField("Minutes", value: $recipe.cook_time_minutes, format: .number) // user inputs
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad) // specifies what keyboard type will pop up
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Servings")
                            .font(.headline)
                        TextField("Servings", value: $recipe.servings, format: .number) // user inputs
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }

                // cuisine Tag
                VStack(alignment: .leading) {
                    Text("Cuisine")
                        .font(.headline)
                    
                    
                    Picker("Select cuisine", selection: $recipe.cuisine_tag) {
                        ForEach(cuisineOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    
                }
                // type Tag
                VStack(alignment: .leading) {
                    Text("Type")
                        .font(.headline)

                    Picker("Select type", selection: $recipe.type_tag) {
                        ForEach(typeOptions, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }

                // description
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.headline)
                    TextEditor(text: $recipe.description)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                // ingredients
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                    TextEditor(text: $recipe.ingredients)
                        .frame(height: 150)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                // instructions
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                    TextEditor(text: $recipe.instructions)
                        .frame(height: 200)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // content
                VStack(alignment: .leading) {
                    Text("Content")
                        .font(.headline)
                    TextEditor(text: $recipe.content)
                        .frame(height: 200)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }

                // the create button
                Button(action: {
                    // sets the required fields that are passed into the function call
                    recipe.author_id = authViewModel.user.id.uuidString
                    usersViewModel.createRecipe(newRecipe: recipe)
                    dismiss()
                }) {
                    Text("Create Recipe")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        // make sure it is blue when the user filled in everything and gray if not
                        .background(
                            (!recipe.title.isEmpty &&
                             !recipe.ingredients.isEmpty &&
                             !recipe.instructions.isEmpty &&
                             recipe.cook_time_minutes > 0 &&
                             recipe.servings > 0) ? Color.blue : Color.gray
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                // make sure it can only be clicked when the user filled in everything
                .disabled(
                    recipe.title.isEmpty ||
                    recipe.ingredients.isEmpty ||
                    recipe.instructions.isEmpty ||
                    recipe.content.isEmpty ||
                    recipe.cook_time_minutes <= 0 ||
                    recipe.servings <= 0
                )
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("New Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}
