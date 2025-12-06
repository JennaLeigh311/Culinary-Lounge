//
//  CreateRecipeView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 12/2/25.
//

import SwiftUI

let cuisineOptions = ["American", "Italian", "Mexican", "Asian", "French", "Indian"]
let typeOptions = ["Breakfast", "Lunch", "Dinner", "Dessert", "Snack", "Side"]

struct CreateRecipeView: View {
    @EnvironmentObject var usersViewModel: UsersViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var recipe = RecipeDTO()
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Title
                VStack(alignment: .leading) {
                    Text("Recipe Title")
                        .font(.headline)
                    TextField("Enter recipe title", text: $recipe.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Cook Time and Servings Row
                HStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        Text("Cook Time (min)")
                            .font(.headline)
                        TextField("Minutes", value: $recipe.cook_time_minutes, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Servings")
                            .font(.headline)
                        TextField("Servings", value: $recipe.servings, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }

                // Cuisine Tag
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

                // Type Tag
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

                // Description
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

                // Ingredients
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

                // Instructions
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

                // Create Button
                Button(action: {
                    recipe.author_id = authViewModel.user.id.uuidString
                    usersViewModel.createRecipe(newRecipe: recipe)
                    dismiss()
                }) {
                    Text("Create Recipe")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
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
                .disabled(
                    recipe.title.isEmpty ||
                    recipe.ingredients.isEmpty ||
                    recipe.instructions.isEmpty ||
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
