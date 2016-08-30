//
//  CollectionViewAndTableViewTests.swift
//  TraktTVUITests
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import XCTest

class CollectionViewAndTableViewTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    override func tearDown() {
        super.tearDown()
    }
    /*
    func testCollectionViewAndTableView() {
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containingType(.StaticText, identifier:"Alice Through the Looking Glass").childrenMatchingType(.Other).element.tap()
        app.tables.buttons["CloseButton"].tap()
    }*/
}
