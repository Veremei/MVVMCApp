//
//  StringsListViewModelTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import XCTest

final class StringsListViewModelTests: XCTestCase {

    private let dataService = StubRandomStringsDataService()
    private var sut: StringsListViewModel!

    override func setUp() {
        super.setUp()
        sut = StringsListDefaultViewModel(dataService: dataService)
    }

    func testFetchDataSuccess() {
        // Given
        let expectation = expectation(description: "Random strings request")
        let expectedStrings = ["1", "2"]
        dataService.requestResult = .success(expectedStrings)

        // When
        dataService.loadStrings { result in
            switch result {
            case .success(let strings):
                XCTAssertEqual(strings, expectedStrings)
            case .failure:
                XCTFail("Load strings shouldn't fail")
            }
        }

        sut.fetchData { _ in
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.strings, expectedStrings)
    }

    func testFetchDataFailed() {
        // Given
        let expectation = expectation(description: "Random strings request")
        let expectedStrings = ["1", "2"]
        dataService.requestResult = .success(expectedStrings)

        // When
        dataService.loadStrings { result in
            switch result {
            case .success(let strings):
                XCTAssertEqual(strings, expectedStrings)
            case .failure:
                XCTFail("Loading strings shouldn't fail")
            }
        }

        dataService.requestResult = .failure(NetworkServiceError.commonError)

        sut.fetchData { _ in
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.strings, [])
    }

    func testLoadStringsFailed() {
        // Given
        let expectation = expectation(description: "Random strings request")
        dataService.requestResult = .failure(AppError.common)

        // When
        dataService.loadStrings { result in
            switch result {
            case .success:
                XCTFail("Loading strings should fail")
            case .failure(let err):
                XCTAssertEqual(err as! AppError, AppError.common)
            }
        }

        sut.fetchData { _ in
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(sut.strings.isEmpty)
    }
}
