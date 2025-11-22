//
//  HomePage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var filtersViewModel: FiltersViewModel // for filtering recipes
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    @State private var searchText = ""
    
    var body: some View {
        
        VStack (spacing: 15){
            // We want the logo and search bar on the same horizontal stack
            VStack {
                // logo
                VStack(spacing: 8) {
                    Image(systemName: "fork.knife.circle") // system icon (maybe temporary)
                        .resizable() // this is to tell swift not to use the system default size,
                        // and to instead be able to specify the size myself
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.orange, .yellow)
                    
                    Text("Culinary Lounge") // my app name
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }

                HStack {
                    SearchBar(text: .constant(""))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.gray.opacity(0.1)) // subtle translucent background
            
            FiltersView()

            // a scrollable view
            ScrollView {
            // in the future I need to have some logic for this to choose which ones to show (based on tags)
            // and also iterate through them automatically not manually
                LazyVStack (spacing: 15){
                    // render the recipe card for each recipe that's selected
                    ForEach(recipesViewModel.recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
        }
        .onAppear {
            
            recipesViewModel.recipes = [] // clear any old data
            recipesViewModel.fetchRecipe()
        }
    }
}
