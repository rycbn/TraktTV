//
//  TrendingMovieTests.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingMovieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func test_ShouldSetTitleTaglineSlugThumbPoster() {
        let sut = TrendingMovie(title: "title", slug: "slug", tagline: "tagline", overview: "overview", rating: 3, genres: ["Action","Horror"], thumb: "thumb", poster: "poster")
        XCTAssertEqual(sut.title, "title")
        XCTAssertEqual(sut.slug, "slug")
        XCTAssertEqual(sut.tagline, "tagline")
        XCTAssertEqual(sut.overview, "overview")
        XCTAssertEqual(sut.rating, 3)
        XCTAssertEqual(sut.genres, ["Action", "Horror"])
        XCTAssertEqual(sut.thumb, "thumb")
        XCTAssertEqual(sut.poster, "poster")
    }
}
