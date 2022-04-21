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
        let expectation = expectation(description: "Random strings request")
        let expectedStrings = ["1", "2"]
        dataService.requestResult = .success(expectedStrings)

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

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.strings, expectedStrings)
    }

    func testFetchDataFailed() {
        let expectation = expectation(description: "Random strings request")
        let expectedStrings = ["1", "2"]
        dataService.requestResult = .success(expectedStrings)

        dataService.loadStrings { result in
            switch result {
            case .success(let strings):
                XCTAssertEqual(strings, expectedStrings)
            case .failure:
                XCTFail("Load strings shouldn't fail")
            }
        }

        dataService.requestResult = .failure(NetworkServiceError.commonError)

        sut.fetchData { _ in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(sut.strings, [])
    }
}
