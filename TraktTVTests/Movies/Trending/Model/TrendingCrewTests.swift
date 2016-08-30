//
//  TrendingCrewTests.swift
//  TraktTV
//
//  Created by Roger Yong on 22/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingCrewTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func test_ShouldSetJobName() {
        let sut = TrendingCrew(job: "Job", name: "Name", headshot: nil)
        XCTAssertEqual(sut.job, "Job")
        XCTAssertEqual(sut.name, "Name")
    }
    func test_ShouldSetJobNameHeadshot() {
        let sut = TrendingCrew(job: "Job", name: "Name", headshot: "Headshot")
        XCTAssertEqual(sut.job, "Job")
        XCTAssertEqual(sut.name, "Name")
        XCTAssertEqual(sut.headshot, "Headshot")
    }
}
