//
//  TrendingDetailViewController.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TrendingDetailViewController: UITableViewController {

    lazy var trendingDetailDataManager = TrendingDetailDataManager()
    var model: TrendingMovie!

    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var trendingDetailDataProvider: TrendingDetailDataProvider!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView?.imageFromUrl(self.model.poster)
            posterImageView?.layer.addAnimation(imageTransition(), forKey: nil)
        }
    }
    @IBOutlet weak var ratingTextLabel: UILabel! {
        didSet {
            ratingTextLabel?.text = self.model.formattedRating
            ratingTextLabel?.textColor = UIColor.colorFromHexRGB(Colour.rating)
        }
    }
    @IBOutlet weak var overviewTextLabel: UILabel! {
        didSet {
            overviewTextLabel?.text = self.model.overview
        }
    }
    @IBOutlet weak var genresTextLabel: UILabel! {
        didSet {
            genresTextLabel?.text = self.model.formattedGenres.capitalizedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = trendingDetailDataProvider
        tableView.delegate = trendingDetailDataProvider
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureData()
    }
}
// MARK:- Configuration
extension TrendingDetailViewController {

    func configureData() {
        if isNetworkReachableOrHasCellularCoverage() {
            loadingMovieCastCrew()
        } else {
            displayNetworkAlert()
        }
    }

    func loadingMovieCastCrew() {
        trendingDetailDataManager.delegate = self
        trendingDetailDataManager.loadMovieCastCrew(model.slug)
    }

    func displayNetworkAlert() {
        displayAlertWithTitle(Translation.networkErrorTitle, message: Translation.networkErrorMessage, viewController: self)
    }

    func displayApiAlert() {
        displayAlertWithTitle(Translation.apiErrorTitle, message: Translation.apiErrorMessage, viewController: self)
    }
}
// MARK:- TrendingDetailDataManagerDelegate
extension TrendingDetailViewController: TrendingDetailDataManagerDelegate {

    func foundAll(cast: [TrendingCast], crew: [TrendingCrew]) {
        trendingDetailDataProvider?.trendingDetailDataManager = trendingDetailDataManager
        trendingDetailDataProvider?.trendingDetailDataManager?.castLists = cast
        trendingDetailDataProvider?.trendingDetailDataManager?.crewLists = crew
        trendingDetailDataProvider?.tableView = tableView
        tableView.reloadData()
    }

    func ApiError() {
        displayApiAlert()
    }
}
