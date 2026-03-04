//
//  RecipeDTOTests.swift
//  recipeappTests
//
//  Created for frontend unit testing.
//

import XCTest
@testable import recipeapp

final class RecipeDTOTests: XCTestCase {

    // Default Values
    func testRecipeDTODefaultValues() {
        let recipe = RecipeDTO()
        XCTAssertNil(recipe.id, "Default id should be nil")
        XCTAssertEqual(recipe.title, "")
        XCTAssertEqual(recipe.author_id, "")
        XCTAssertEqual(recipe.description, "")
        XCTAssertEqual(recipe.cook_time_minutes, 0)
        XCTAssertEqual(recipe.servings, 0)
        XCTAssertEqual(recipe.cuisine_tag, "")
        XCTAssertEqual(recipe.type_tag, "")
        XCTAssertEqual(recipe.ingredients, "")
        XCTAssertEqual(recipe.instructions, "")
        XCTAssertEqual(recipe.content, "")
    }

    // Identifiable
    func testRecipeDTOIdentifiable() {
        var recipe = RecipeDTO()
        let testID = UUID()
        recipe.id = testID
        XCTAssertEqual(recipe.ID, testID, "Computed ID should match the stored id")
    }

    // Codable (encode/decode round-trip)
    func testRecipeDTOCodableRoundTrip() throws {
        let testID = UUID()
        let now = Date()

        // Create a recipe with all fields set
        var recipe = RecipeDTO()
        recipe.id = testID
        recipe.title = "Spaghetti Bolognese"
        recipe.author_id = UUID().uuidString
        recipe.description = "A classic Italian dish"
        recipe.cook_time_minutes = 45
        recipe.servings = 4
        recipe.cuisine_tag = "Italian"
        recipe.type_tag = "Dinner"
        recipe.ingredients = "pasta, ground beef, tomato sauce"
        recipe.instructions = "Cook pasta. Brown beef. Mix with sauce."
        recipe.content = "Full recipe content here"
        recipe.date_posted = now

        // Encode to JSON
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(recipe)

        // Decode back to a RecipeDTO
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(RecipeDTO.self, from: data)

        // Verify all fields match
        XCTAssertEqual(decoded.id, testID)
        XCTAssertEqual(decoded.title, "Spaghetti Bolognese")
        XCTAssertEqual(decoded.cook_time_minutes, 45)
        XCTAssertEqual(decoded.servings, 4)
        XCTAssertEqual(decoded.cuisine_tag, "Italian")
        XCTAssertEqual(decoded.type_tag, "Dinner")
    }

    // JSON decoding from server-like payload
    func testRecipeDTODecodesFromJSON() throws {
        let id = UUID()
        // This JSON string simulates what the server might return for a recipe
        let json = """ 
        {
            "id": "\(id.uuidString)",
            "title": "Pancakes",
            "author_id": "\(UUID().uuidString)",
            "description": "Fluffy pancakes",
            "cook_time_minutes": 20,
            "servings": 2.5,
            "cuisine_tag": "American",
            "type_tag": "Breakfast",
            "ingredients": "flour, eggs, milk",
            "instructions": "Mix and cook",
            "content": "",
            "date_posted": "2025-01-15T10:30:00Z"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let recipe = try decoder.decode(RecipeDTO.self, from: json)

        XCTAssertEqual(recipe.id, id)
        XCTAssertEqual(recipe.title, "Pancakes")
        XCTAssertEqual(recipe.servings, 2.5)
        XCTAssertEqual(recipe.cuisine_tag, "American")
    }

    // Array decoding (as fetchRecipes does)
    func testRecipeDTOArrayDecoding() throws {
        // This JSON simulates an array of recipes returned by the server
        let json = """
        [
            {
                "id": "\(UUID().uuidString)",
                "title": "Recipe 1",
                "author_id": "",
                "description": "",
                "cook_time_minutes": 10,
                "servings": 1,
                "cuisine_tag": "",
                "type_tag": "",
                "ingredients": "",
                "instructions": "",
                "content": "",
                "date_posted": "2025-06-01T00:00:00Z"
            },
            {
                "id": "\(UUID().uuidString)",
                "title": "Recipe 2",
                "author_id": "",
                "description": "",
                "cook_time_minutes": 20,
                "servings": 2,
                "cuisine_tag": "",
                "type_tag": "",
                "ingredients": "",
                "instructions": "",
                "content": "",
                "date_posted": "2025-06-02T00:00:00Z"
            }
        ]
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let recipes = try decoder.decode([RecipeDTO].self, from: json)

        XCTAssertEqual(recipes.count, 2)
        XCTAssertEqual(recipes[0].title, "Recipe 1")
        XCTAssertEqual(recipes[1].title, "Recipe 2")
    }
}
