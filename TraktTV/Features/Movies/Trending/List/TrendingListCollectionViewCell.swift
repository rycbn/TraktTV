//
//  TrendingListCollectionViewCell.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class TrendingListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var taglineTextLabel: UILabel!

    func configureTrendingListCell(title: String, tagline: String) {
        titleTextLabel?.text = title
        taglineTextLabel?.text = tagline
    }
    
    func configureImageView(image: UIImage?) {
        imageView?.backgroundColor = UIColor.randomColor()
        imageView?.image = image?.decompressedImage
    }

    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let featuredHeight = Measurement.featuredHeight
        let standardHeight = Measurement.standardHeight
        let maxAlpha = Measurement.maxAlpha
        let minAlpha = Measurement.minAlpha

        let delta = 1 - (featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight)
        let scale = max(delta, 0.5)
        let alpha = maxAlpha - (delta * (maxAlpha - minAlpha))

        overlayView.alpha = alpha
        titleTextLabel.transform = CGAffineTransformMakeScale(scale, scale)
    }
}
