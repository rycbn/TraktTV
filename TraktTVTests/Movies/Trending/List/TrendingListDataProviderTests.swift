//
//  TrendingListDataProviderTests.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingListDataProviderTests: XCTestCase {

    var sut: TrendingListDataProvider!
    var collectionView: UICollectionView!
    var controller: TrendingListViewController!

    override func setUp() {
        super.setUp()
        sut = TrendingListDataProvider()
        sut.trendingListDataManager = TrendingListDataManager()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewControllerWithIdentifier("TrendingListStoryboardID") as! TrendingListViewController
        _ = controller.view
        collectionView = controller.collectionView
        collectionView.dataSource = sut
        collectionView.delegate = sut
    }
    override func tearDown() {
        super.tearDown()
    }
}
