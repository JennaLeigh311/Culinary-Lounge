//
//  SearchBarView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 11/21/25.
//

// https://www.appcoda.com/swiftui-search-bar/

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false // this is to trigger the little 'x' button to clear all of the search values

    var body: some View {
        HStack {
            
            TextField("Search", text: $text)
                // styling
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    // this is what is inside of the Field
                    HStack {
                        // the search icon
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        // and the 'x' button to clear search values
                        // this will be true once the user taps the search bar
                        if isEditing {
                            // this button on the right is to clear the search bar of any content
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

        }
    }
}
