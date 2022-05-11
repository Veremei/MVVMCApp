//
//  RandomStringURLBuilderTests.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import XCTest

final class RandomStringURLBuilderTests: XCTestCase {

    func testThatBuiltURLIsCorrect() {
        let expectedUrl = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")
        let url = RandomStringURLBuilder.build().url

        XCTAssertNotNil(url)
        XCTAssertEqual(url, expectedUrl)
    }

    func testBuildURLForNum() {
        let num = 5
        let expectedUrl = URL(string: "https://www.random.org/strings/?num=\(num)&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")
        let url = RandomStringURLBuilder.build(num: num).url

        XCTAssertNotNil(url)
        XCTAssertEqual(url, expectedUrl)
    }

    func testBuildURLForLen() {
        let len = 5
        let expectedUrl = URL(string: "https://www.random.org/strings/?num=10&len=\(len)&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")
        let url = RandomStringURLBuilder.build(len: len).url

        XCTAssertNotNil(url)
        XCTAssertEqual(url, expectedUrl)
    }

    func testBuildURLForSeveralParams() {
        let num = 5
        let len = 5
        let lowerAlpha = false
        let expectedUrl = URL(string: "https://www.random.org/strings/?num=\(num)&len=\(len)&digits=on&upperalpha=on&loweralpha=off&unique=on&format=plain&rnd=new")
        let url = RandomStringURLBuilder.build(num: num, len: len, loweralpha: lowerAlpha).url

        XCTAssertNotNil(url)
        XCTAssertEqual(url, expectedUrl)
    }

}
