//
//  RandomStringsDataServiceTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import XCTest
import FileProvider

class RandomStringsDataServiceTests: XCTestCase {

    private var dataService: RandomStringsDataProtocol!
    private let networkService = NetworkServiceFake()

    lazy var bundle = Bundle(for: type(of: self))

    private func load(from file: String) throws -> Data {
        guard let path = bundle.url(forResource: file, withExtension: "") else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        do {
            return try Data(contentsOf: path)
        } catch let error {
            fatalError("Failed to adjust \(file) due to error: \(error)")
        }
    }

    override func setUp() {
        super.setUp()
        dataService = RandomStringsDataService(networkService: networkService)
    }

    func testLoadingDataAndParsingIntoArray() {
        // Given
        let expectation = expectation(description: "Loaded strings")
        let expectedStrings = ["first", "second", "third"]
        var stringsResult: [String]!

        let mockedResponse = try! load(from: "random_strings.txt")
        networkService.requestResult = .success(mockedResponse)

        // When
        dataService.loadStrings { result in
            switch result {
            case .success(let strings):
                stringsResult = strings
                expectation.fulfill()
            case .failure:
                XCTFail("Loading strings shouldn't fail")
            }
        }

        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(stringsResult, expectedStrings)
    }
}
