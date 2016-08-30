//
//  TrendingListViewControllerTests.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingListViewControllerTests: XCTestCase {

    var sut: TrendingListViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("TrendingListStoryboardID") as! TrendingListViewController
        _ = sut.view
    }
    override func tearDown() {
        super.tearDown()
    }
    func test_ViewControllerNotNil() {
        XCTAssertNotNil(sut.view)
    }
    func test_HasNoContentView() {
        XCTAssertNotNil(sut.noContentView)
    }
    func test_HasLoadingView() {
        XCTAssertNotNil(sut.loadingView)
    }
    func test_HasCollectionView() {
        XCTAssertNotNil(sut.collectionView)
    }
}
