//
//  InstructionsView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/19/25.
//


import SwiftUI


struct InstructionsView: View {
    @StateObject private var recipesViewModel = RecipesViewModel()
    var body: some View {
        Text("instructions")
            .cornerRadius(8)
            .background(Color.white)
            .frame(maxWidth: .infinity, minHeight: 1)
    }
}
