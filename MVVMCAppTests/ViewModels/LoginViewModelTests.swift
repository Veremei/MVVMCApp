//
//  LoginViewModelTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import XCTest

final class LoginViewModelTests: XCTestCase {
    private var sut: LoginViewModel!

    override func setUp() {
        super.setUp()
        sut = LoginDefaulViewModel(credentials: LoginCredentials(user: "", password: ""))
    }

    func testThatCredentialsAreValid() {
        // Given
        let expectation = expectation(description: "Successful login")
        let expectedUser = "user"
        let expectedPassword = "123qwe"

        XCTAssertEqual(sut.credentials?.user, "")
        XCTAssertEqual(sut.credentials?.password, "")

        // When
        sut.login(user: expectedUser, password: expectedPassword) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("Expected .success result")
            }
        }

        // Then
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(sut.credentials?.user, expectedUser)
        XCTAssertEqual(sut.credentials?.password, expectedPassword)
    }

    func testThatCredentialsAreInvalid() {
        // Given
        let expectation = expectation(description: "Failed login attempt")
        let expectedUser = "user"

        XCTAssertEqual(sut.credentials?.user, "")
        XCTAssertEqual(sut.credentials?.password, "")

        // When
        sut.login(user: expectedUser, password: "123") { result in
            switch result {
            case .success:
                XCTFail("Expected .failure result")
            case .failure(let error):
                XCTAssertEqual(error as! LoginError, LoginError.incorrectCredentials)
                expectation.fulfill()
            }
        }

        // Then
        wait(for: [expectation], timeout: 2)

        XCTAssertEqual(sut.credentials?.user, expectedUser)
        XCTAssertEqual(sut.credentials?.password, "")
    }
}
