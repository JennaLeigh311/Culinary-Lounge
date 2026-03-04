//
//  AuthViewModelTests.swift
//  recipeappTests
//
//  Created for frontend unit testing.
//

import XCTest
@testable import recipeapp

final class AuthViewModelTests: XCTestCase {

    var user: User!
    var authVM: AuthViewModel!

    // setUp and tearDown to create a fresh AuthViewModel and User for each test
    override func setUp() {
        super.setUp()
        user = User()
        authVM = AuthViewModel(user: user)
    }

    // Clean up references after each test
    override func tearDown() {
        authVM = nil
        user = nil
        super.tearDown()
    }

    //  Initial State
    func testInitialSignInState() {
        XCTAssertEqual(authVM.signInState, .notAttempted,
                       "Sign-in state should start as .notAttempted")
    }

    func testInitialSignUpState() {
        XCTAssertEqual(authVM.signUpState, .notAttempted,
                       "Sign-up state should start as .notAttempted")
    }

    func testInitSetsUser() {
        XCTAssertTrue(authVM.user === user,
                      "AuthViewModel should hold a reference to the injected User")
    }

    // login tests
    func testLoginWithEmptyEmailDoesNotChangeState() {
        authVM.login(email: "", password: "password123")
        // Because email is empty the method returns early; state stays .notAttempted
        XCTAssertEqual(authVM.signInState, .notAttempted,
                       "Empty email should not trigger a network call or change state")
    }

    func testLoginWithEmptyPasswordDoesNotChangeState() {
        authVM.login(email: "test@test.com", password: "")
        XCTAssertEqual(authVM.signInState, .notAttempted,
                       "Empty password should not trigger a network call or change state")
    }

    func testLoginWithBothEmptyDoesNotChangeState() {
        authVM.login(email: "", password: "")
        XCTAssertEqual(authVM.signInState, .notAttempted)
    }

    // sign up tests - we can't easily test the network call, but we can verify the state doesn't change with invalid input
    func testSignupWithEmptyEmailDoesNotChangeState() {
        authVM.signup(email: "", password: "password123")
        // signup resets state to .notAttempted at start; empty fields should not crash
        XCTAssertEqual(authVM.signUpState, .notAttempted)
    }

    // State mutation tests - we can set the state directly and verify it changes as expected
    func testSignInStateCanBeSetToSuccess() {
        authVM.signInState = .success
        XCTAssertEqual(authVM.signInState, .success)
    }

    func testSignInStateCanBeSetToFailed() {
        authVM.signInState = .failed
        XCTAssertEqual(authVM.signInState, .failed)
    }

    func testSignUpStateCanBeSetToSuccess() {
        authVM.signUpState = .success
        XCTAssertEqual(authVM.signUpState, .success)
    }

    func testSignUpStateCanBeSetToFailed() {
        authVM.signUpState = .failed
        XCTAssertEqual(authVM.signUpState, .failed)
    }

    // User propagation tests - verify that changes to the User in AuthViewModel are reflected in the User object
    func testUserPropertiesReflectInViewModel() {
        let testID = UUID()
        user.id = testID
        user.username = "jenna"
        user.email = "jenna@example.com"
        user.role = "USER"
        user.token = "tok_123"

        XCTAssertEqual(authVM.user.id, testID)
        XCTAssertEqual(authVM.user.username, "jenna")
        XCTAssertEqual(authVM.user.email, "jenna@example.com")
        XCTAssertEqual(authVM.user.role, "USER")
        XCTAssertEqual(authVM.user.token, "tok_123")
    }
}
