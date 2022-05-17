//
//  LoginScreenTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 17.05.2022.
//

import XCTest

final class LoginViewControllerTests: XCTestCase {

    var sut: LoginViewController!
    var loginModel: LoginViewModel!

    override func setUp() {
        super.setUp()
        loginModel = LoginDefaulViewModel()
        sut = LoginViewController(viewModel: loginModel)
        sut.loadViewIfNeeded()
    }

    func testThatCredsFieldsAreEmpty() {
        // Given

        // When
        loginModel.credentials = nil

        // Then
        XCTAssertTrue(sut.userFieldIsEmpty)
        XCTAssertTrue(sut.passwordFieldIsEmpty)
    }

    func testThatUsernameFieldIsNotEmpty() {
        // Given
        loginModel = LoginDefaulViewModel(credentials: LoginCredentials(user: "user", password: "123"))
        sut = LoginViewController(viewModel: loginModel)

        // When
        sut.loadViewIfNeeded()

        // Then
        XCTAssertFalse(sut.userFieldIsEmpty)
        XCTAssertTrue(sut.passwordFieldIsEmpty)
    }
}
