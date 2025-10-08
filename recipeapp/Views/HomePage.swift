//
//  HomePage.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var filtersViewModel: FiltersViewModel // for filtering recipes

    var body: some View{
        VStack (spacing: 15){
            TopBarView()
            FiltersView()

            // a scrollable view
            ScrollView {
                // in the future I need to have some logic for this to choose which ones to show (based on tags)
                // and also iterate through them automatically not manually
                LazyVStack (spacing: 15){
                    // render the recipe card for each recipe that's selected
                    ForEach(filtersViewModel.filteredRecipes, id: \.id) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                }
            }
            BottomMenuView()
        }
    }
}
