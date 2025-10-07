//
//  TopBar.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI
import SwiftData

struct TopBarView: View {
    // it's best practice to make this variable private so that other views can't access it and write over it
    // I will make this a search view model probably because I need there to be actual logic that handles filtering
    @State private var searchText = ""

    var body: some View {
        // We want the logo and search bar on the same horizontal stack
        HStack {
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

            Spacer() // makes the components take as much space as they can
            // helping with device cross-compatibility too

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 4)
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 5)
            .background(Color(.white))
            .cornerRadius(18)
            .frame(maxWidth: 220)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.gray.opacity(0.1)) // subtle translucent background
    }
}
