//
//  FiltersView.swift
//  recipeapp
//
//  Created by Jenna Bunescu on 9/29/25.
//

import SwiftUI

// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations

struct FiltersView: View {
    // this view creates the view model and needs to keep it alive (keeps it stored in memory even with view re-renders)
    // I'm actually debating whether to make this an environment object as well so that the recipes views can filter based on it and so that it can stay constant between view calls
    @EnvironmentObject var viewModel: FiltersViewModel
    @EnvironmentObject var recipesViewModel: RecipesViewModel
 
    // var body is a computed property that's called again and again when something changes, and this returns a view ('some' indicates an opaque return type - return a type that conforms to View(a protocol) but doesn't specify which one) fvg v cv v cv bvg  vn vbcxdcfvb nbgvfcdsxc vvcx
    // mn 098765432
    var body: some View {
        
        // Zstack because I want the filters to come on top of the view (along with using the overlay modifier)
        ZStack {
            HStack(spacing: 12) {
                
                // Type Filter Button
                // This is a closure implementation -
                // Button's constructor takes in an escaping closure as its action
                // The reason why this is an escaping closure is because the button's initializer stores the closure when the object is created, so that it can be run later when the user presses the button
                Button(action: { viewModel.toggleTypesList() }) {
                    HStack {
                        // Show the raw value of the enum TypeTags
                        Text(viewModel.selectedTypeTag.rawValue)
                            .font(.headline)
                        // Have an arrow right beside it, pointing down initially
                        Image(systemName: "chevron.down")
                            // have a rotatioin effect and move the arrow to 180 degrees if the showTypeList is toggled on (which it is when the button is pressed) or move it to 0 degrees (no rotation) when the list isn't shown
                            .rotationEffect(.degrees(viewModel.showTypesList ? 180 : 0))
                            // specify size and line weight
                            .font(.system(size: 14, weight: .semibold))
                    }
                    // styling
                    .padding()
                    .frame(maxWidth: 150, minHeight: 20)
                    .background(Color.gray.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(18)
                }
                
                // Cuisine Filter Button
                Button(action: { viewModel.toggleCuisinesList() }) {
                    HStack {
                        Text(viewModel.selectedCuisineTag.rawValue)
                            .font(.headline)
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(viewModel.showCuisinesList ? 180 : 0))
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding()
                    .frame(maxWidth: 150, minHeight: 20)
                    .background(Color.gray.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(18)
                }
            }
            
            // So I kept running into the issue where my dropdowns would be "behind" the other views, and I wasn't able to click on them, so as solution was to use "overlay" which tells the view to draw this view on top of itself
            // bottom tells it to anchor the dropdown at the bottom edge of its parent
            .overlay(alignment: .bottom) {
                
                // TypeTags dropdown
                // Check if showTypesList is toggled
                if viewModel.showTypesList {
                    VStack(spacing: 0) {
                        // This is a closure implementation
                        // ForEach is a view that takes my array of all tags and creates a view for each item
                        // The body inside { type in } is an argument which takes in an escaping closure
                        // This closure is later called to build the child views, but it's not called initially, it's stored inside the self.content of ForEach
                        
                        // type in is syntax that passes in "type" as a parameter to the closure, and in is the separator between the parameters and the body of the closure
                        ForEach(viewModel.availableTypeTags, id: \.self) { typeTag in
                            Button(action: { // as we've seen above this is again a closure implementation
                                viewModel.select(type: typeTag)
                            }) {
                                Text(typeTag.rawValue)
                                    .padding()
                                    .frame(maxWidth: 150)
                                    .background(Color.gray.opacity(0.3))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(18)
                    .position(x: 75, y: 170) // hardcoding the position for now because I didn't know how to align it
                }
                
                // CuisineTags dropdown
                if viewModel.showCuisinesList {
                    
                    VStack(spacing: 0) {
                        
                        ForEach(viewModel.availableCuisneTags, id: \.self) { cuisineTag in
                            Button(action: {
                                viewModel.select(cuisine: cuisineTag)
                            }) {
                                
                                Text(cuisineTag.rawValue)
                                    .padding()
                                    .frame(maxWidth: 150)
                                    .background(Color.gray.opacity(0.3))
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(18)
                    .position(x: 235, y: 197)
                }
            }
        }
        .zIndex(1) // so this one is cool because it helped me solve the issue of the view appearing "behind" the other views. zIndex is a modifier that tells the view where to sit in the layout (behind everything, on top, in the middle). So when zIndex == 0 the buttons are not clickable because the view is covered by another.
        .animation(.easeInOut, value: viewModel.showTypesList) // animations!!
        .animation(.easeInOut, value: viewModel.showCuisinesList)
    }
}
