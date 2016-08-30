//
//  TrendingDetailTableViewCell.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class TrendingDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var customImageViewContainer: UIView!
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customTitleTextLabel: UILabel!
    @IBOutlet weak var customDetailTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
    }

    func configureCastCell(character: String, name: String) {
        customTitleTextLabel?.text = name
        customDetailTextLabel?.text = character
    }

    func configureCrewCell(job: String, name: String) {
        customTitleTextLabel?.text = name
        customDetailTextLabel?.text = job
    }

    func configureHeadshotImageView(headshotImage: UIImage?) {
        customImageView?.backgroundColor = UIColor.randomColor()
        customImageView?.image = headshotImage?.decompressedImage
    }
}
