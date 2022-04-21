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
        coordinator.start()
        XCTAssertTrue(coordinator.rootViewController.children.last is LoginViewController)
    }

    func testThatRootHasListAfterUserLoggedIn() {
        let expectation = expectation(description: "List vc is presented")
        coordinator.start()
        XCTAssertTrue(coordinator.rootViewController.children.last is LoginViewController)

        coordinator.loggedIn()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(coordinator.rootViewController.children.last is StringsListViewController)
    }
}
