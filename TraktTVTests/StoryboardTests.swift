//
//  StoryboardTests.swift
//  TraktTV
//
//  Created by Roger Yong on 22/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class StoryboardTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    func test_InitViewController_IsTrendingListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers[0]
        XCTAssertTrue(rootViewController is TrendingListViewController)
    }
}
