//
//  TrendingListCollectionViewCellTests.swift
//  TraktTV
//
//  Created by Roger Yong on 22/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest
@testable import TraktTV

class TrendingListCollectionViewCellTests: XCTestCase {

    var collectionView: UICollectionView!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("TrendingListStoryboardID") as! TrendingListViewController
        _ = controller.view
        collectionView = controller.collectionView
        collectionView.dataSource = FakeDataSource()

    }
    override func tearDown() {
        super.tearDown()
    }
    /*
    func test_HasImageView() {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TrendingListCollectionViewCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! TrendingListCollectionViewCell
        XCTAssertNotNil(cell.imageView)
    }
    func test_HasOverlayView() {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TrendingListCollectionViewCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! TrendingListCollectionViewCell
        XCTAssertNotNil(cell.overlayView)
    }
    func test_HasTitleTextLabel() {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TrendingListCollectionViewCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! TrendingListCollectionViewCell
        XCTAssertNotNil(cell.titleTextLabel)
    }
    func test_HasTaglineTextLabel() {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TrendingListCollectionViewCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! TrendingListCollectionViewCell
        XCTAssertNotNil(cell.taglineTextLabel)
    }
    */
}
extension TrendingListCollectionViewCellTests {
    class FakeDataSource: NSObject, UICollectionViewDataSource {
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            return UICollectionViewCell()
        }
    }
}
