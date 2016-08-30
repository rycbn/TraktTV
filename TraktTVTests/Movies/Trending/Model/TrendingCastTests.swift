//
//  TrendingCastTests.swift
//  TraktTV
//
//  Created by Roger Yong on 22/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingCastTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func test_ShouldSetCharacterName() {
        let sut = TrendingCast(character: "Character", name: "Name", headshot: nil)
        XCTAssertEqual(sut.character, "Character")
        XCTAssertEqual(sut.name, "Name")
    }
    func test_ShouldSetCharacterNameHeadshot() {
        let sut = TrendingCast(character: "Character", name: "Name", headshot: "Headshot")
        XCTAssertEqual(sut.character, "Character")
        XCTAssertEqual(sut.name, "Name")
        XCTAssertEqual(sut.headshot, "Headshot")
    }
}
