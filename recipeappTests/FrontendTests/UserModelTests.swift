//
//  UserModelTests.swift
//  recipeappTests
//
//  Created for frontend unit testing.
//

import XCTest
@testable import recipeapp

final class UserModelTests: XCTestCase {

    //User Defaults
    func testUserDefaultValues() {
        let user = User()
        XCTAssertFalse(user.id.uuidString.isEmpty, "User should have a default UUID")
        XCTAssertEqual(user.username, "", "Default username should be empty")
        XCTAssertEqual(user.email, "", "Default email should be empty")
        XCTAssertEqual(user.role, "", "Default role should be empty")
        XCTAssertEqual(user.token, "", "Default token should be empty")
    }

    // Identifiable
    func testUserIdentifiable() {
        let user = User()
        // The computed ID property should match the stored id
        XCTAssertEqual(user.ID, user.id, "ID should equal id")
    }

    // Property mutation
    func testUserPropertyMutation() {
        let user = User()
        let testID = UUID()
        user.id = testID
        user.username = "testUser"
        user.email = "test@example.com"
        user.role = "ADMIN"
        user.token = "abc123"

        XCTAssertEqual(user.id, testID)
        XCTAssertEqual(user.username, "testUser")
        XCTAssertEqual(user.email, "test@example.com")
        XCTAssertEqual(user.role, "ADMIN")
        XCTAssertEqual(user.token, "abc123")
    }
}
