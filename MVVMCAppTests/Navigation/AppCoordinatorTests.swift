//
//  AppCoordinatorTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import XCTest

final class AppCoordinatorTests: XCTestCase {

    private var coordinator: AppCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator(window: UIWindow())
    }

    func testThatRootHasLoginScreenOnStart() {
        // Given

        // When
        coordinator.start()

        // Then
        XCTAssertTrue(coordinator.rootViewController.children.last is LoginViewController)
    }

    func testThatRootHasListAfterUserLoggedIn() {
        // Given
        let expectation = expectation(description: "List vc is presented")
        coordinator.start()
        XCTAssertTrue(coordinator.rootViewController.children.last is LoginViewController)

        // When
        coordinator.loggedIn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(coordinator.rootViewController.children.last is StringsListViewController)
    }
}
