//
//  TrendingListViewController.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class TrendingListViewController: UIViewController {

    lazy var trendingListDataManager = TrendingListDataManager()

    @IBOutlet weak var noContentView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trendingListDataProvider: TrendingListDataProvider!

    @IBAction func refresh(sender: UIBarButtonItem) {
        configureData()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
}
// MARK:- Configuration
extension TrendingListViewController {

    func configureData() {
        if isNetworkReachableOrHasCellularCoverage() {
            loadingTrendingMovies()
        } else {
            displayNetworkAlert()
            if trendingListDataManager.lists.count == 0 {
                displayNoContentView()
            }
        }
    }

    func loadingTrendingMovies() {
        navigationItem.rightBarButtonItem?.enabled = false
        displayLoadingView()
        trendingListDataManager.delegate = self
        trendingListDataManager.loadTrendingMovie()
    }

    func displayNetworkAlert() {
        displayAlertWithTitle(Translation.networkErrorTitle, message: Translation.networkErrorMessage, viewController: self)
    }

    func displayApiAlert() {
        displayAlertWithTitle(Translation.apiErrorTitle, message: Translation.apiErrorMessage, viewController: self)
    }

    func displayLoadingView() {
        self.title = Translation.loading
        view = loadingView
    }

    func displayNoContentView() {
        self.title = Translation.noInternetService
        view = noContentView
    }

    func displayCollectionView() {
        self.title = Translation.trendingMovie
        view = collectionView
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.dataSource = trendingListDataProvider
        collectionView.delegate = trendingListDataProvider
    }
}
// MARK:- TrendingListDataManagerDelegate
extension TrendingListViewController: TrendingListDataManagerDelegate {

    func foundAll(data: [TrendingMovie]) {
        navigationItem.rightBarButtonItem?.enabled = true
        displayCollectionView()
        trendingListDataProvider?.trendingListDataManager = trendingListDataManager
        trendingListDataProvider?.trendingListDataManager?.lists = data
        trendingListDataProvider?.navigationController = navigationController
        collectionView.reloadData()
    }
    
    func ApiError() {
        displayApiAlert()
        displayNoContentView()
    }
}
