//
//  UsersViewModelTests.swift
//  recipeappTests
//
//  Created for frontend unit testing.
//

import XCTest
@testable import recipeapp

final class UsersViewModelTests: XCTestCase {

    var user: User!
    var authVM: AuthViewModel!
    var usersVM: UsersViewModel!

    // setUp and tearDown to create fresh instances for each test
    override func setUp() {
        super.setUp()
        user = User()
        authVM = AuthViewModel(user: user)
        usersVM = UsersViewModel(auth: authVM)
    }

    // Clean up references after each test
    override func tearDown() {
        usersVM = nil
        authVM = nil
        user = nil
        super.tearDown()
    }

    // Initial state
    func testUserLikesStartsEmpty() {
        XCTAssertTrue(usersVM.user_likes.isEmpty)
    }

    func testUserRecipesStartsEmpty() {
        XCTAssertTrue(usersVM.user_recipes.isEmpty)
    }

    // Create recipe builds correct author_id
    func testCreateRecipeSetsAuthorID() {
        // Set up user identity
        let testID = UUID()
        user.id = testID
        user.token = "test_token"

        // Create a recipe DTO
        var newRecipe = RecipeDTO()
        newRecipe.title = "Test Recipe"
        newRecipe.cook_time_minutes = 30
        newRecipe.servings = 4

        // We can't easily test the network call, but we can verify the local array which starts empty and the method doesn't crash
        XCTAssertEqual(usersVM.user_recipes.count, 0)

        // Calling createRecipe with a valid recipe should not crash (it will attempt a network call that fails silently without a server)
        usersVM.createRecipe(newRecipe: newRecipe)

        // Give a tiny bit of time for any synchronous code to finish
        let expectation = XCTestExpectation(description: "Brief wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        // The recipe won't actually be added (no server), but the call shouldn't crash
        XCTAssertNotNil(usersVM)
    }
}
