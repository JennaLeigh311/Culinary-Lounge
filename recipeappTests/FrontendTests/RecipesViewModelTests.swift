//
//  RecipesViewModelTests.swift
//  recipeappTests
//
//  Created for frontend unit testing.
//

import XCTest
@testable import recipeapp

final class RecipesViewModelTests: XCTestCase {

    // Initialization
    func testRecipesViewModelInitializes() {
        // RecipesViewModel calls fetchRecipes() in init, which makes a network call.
        // Without a running server the array stays empty, but it should not crash.
        let vm = RecipesViewModel()
        XCTAssertNotNil(vm)
    }

    func testRecipesArrayStartsEmpty() {
        let vm = RecipesViewModel()
        // Even though fetchRecipes fires, without a server the data stays empty
        XCTAssertTrue(vm.recipes.isEmpty,
                      "Recipes should be empty when no server responds")
    }

    // Basic array manipulation tests to ensure we can set and modify the recipes array
    func testCanSetRecipesDirectly() {
        let vm = RecipesViewModel()

        var recipe1 = RecipeDTO()
        recipe1.id = UUID()
        recipe1.title = "Test Recipe"

        vm.recipes = [recipe1]
        XCTAssertEqual(vm.recipes.count, 1)
        XCTAssertEqual(vm.recipes.first?.title, "Test Recipe")
    }

    // Appending to the recipes array should work as expected
    func testCanAppendRecipe() {
        let vm = RecipesViewModel()

        var recipe = RecipeDTO()
        recipe.id = UUID()
        recipe.title = "Added Recipe"

        vm.recipes.append(recipe)
        XCTAssertEqual(vm.recipes.count, 1)
    }

    // Removing all recipes should result in an empty array
    func testCanClearRecipes() {
        let vm = RecipesViewModel()

        var recipe = RecipeDTO()
        recipe.id = UUID()
        recipe.title = "Temp"
        vm.recipes = [recipe]

        vm.recipes.removeAll()
        XCTAssertTrue(vm.recipes.isEmpty)
    }
}
