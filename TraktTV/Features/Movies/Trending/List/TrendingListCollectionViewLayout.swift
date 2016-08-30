//
//  TrendingListCollectionViewLayout.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class TrendingListCollectionViewLayout: UICollectionViewLayout {

    let standardHeight = Measurement.standardHeight
    let featuredHeight = Measurement.featuredHeight
    let dragOffset     = Measurement.dragOffset

    var cached = [UICollectionViewLayoutAttributes]()

    var numberOfItems: Int {
        guard let numberOfItemsInSection = collectionView?.numberOfItemsInSection(0) else { return 0 }
        return numberOfItemsInSection
    }
    
    var width: CGFloat {
        guard let frameWidth = collectionView?.frame else { return 0.0 }
        return CGRectGetWidth(frameWidth)
    }

    var height: CGFloat {
        guard let frameHeight = collectionView?.frame else { return 0.0 }
        return CGRectGetHeight(frameHeight)
    }

    var yOffset: CGFloat {
        guard let offsetY = collectionView?.contentOffset.y else { return 0.0 }
        return offsetY
    }

    var featuredItemIndex: Int {
        return max(0, Int(yOffset / dragOffset))
    }

    var nextItemPercentageOffset: CGFloat {
        return (yOffset / dragOffset) - CGFloat(featuredItemIndex)
    }

    override func collectionViewContentSize() -> CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
        return CGSize(width: width, height: contentHeight)
    }

    override func prepareLayout() {
        cached.removeAll(keepCapacity: false)

        var frame = CGRect()
        var y: CGFloat = 0

        for item in 0..<numberOfItems {
            let indexPath = NSIndexPath(forItem: item, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)

            attributes.zIndex = item

            var height = standardHeight

            if indexPath.item == featuredItemIndex {
                y = yOffset - (standardHeight * nextItemPercentageOffset)
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            } else {
                y = frame.origin.y + frame.size.height
            }

            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cached.append(attributes)
            y = CGRectGetMaxY(frame)
        }
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cached.filter { attributes in
            return CGRectIntersectsRect(attributes.frame, rect)
        }
    }

    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return cached[indexPath.item]
    }

    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
