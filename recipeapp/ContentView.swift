//
//  ContentView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/11/25.
//

import SwiftUI

// View is a protocol
struct ContentView: View {
    var body: some View{
        HStack {
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
        }
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        ZStack { // Z direction is towards the viewer, so it stacks things on top of each other.
            if isFaceUp{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 5)
                Text("MEOW")
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.red)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 5)
            }
            
        }
    }
}

