//
//  LikedRecipesView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 10/6/25.
//

import SwiftUI

// temporary view
// the only difference is the icon for now

struct LikedRecipesView: View {
    @EnvironmentObject var signInViewModel: SignInTempViewModel
    @StateObject private var mealViewModel = MealViewModel()
    
    var body: some View{
        VStack (spacing: 15){
            TopBarView()
            FiltersView()
            ScrollView {
                LazyVStack (spacing: 15){
                    
                    ForEach(mealViewModel.meals) { meal in
                        LikedRecipeCardView(recipe: meal)
                    }

                }
            }
            BottomMenuView()
        }
        .background(Color.pink.opacity(0.3)) // also different background color just to make it more clear that they're different in the demo
        .onAppear {
            let mealNames = ["Arrabiata", "Carbonara", "Sushi"]
            mealViewModel.meals = [] // clear any old data
            for name in mealNames {
                mealViewModel.fetchRemoteData(for: name)
            }
        }
    }
}
