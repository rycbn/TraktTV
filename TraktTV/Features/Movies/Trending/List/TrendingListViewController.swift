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

    @IBOutlet weak var apiErrorView: UIView!
    @IBOutlet weak var offlineView: UIView!
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
            displayOfflineView()
        }
    }

    func loadingTrendingMovies() {
        NetworkManager.networkActivityIndicatorVisible()
        displayLoadingView()
        trendingListDataManager.delegate = self
        trendingListDataManager.loadTrendingMovie()
    }

    func displayOfflineView() {
        navigationItem.rightBarButtonItem?.enabled = true
        self.title = Translation.noNetworkConnection
        view = offlineView
    }

    func displayApiErrorView() {
        navigationItem.rightBarButtonItem?.enabled = true
        self.title = Translation.apiErrorTitle
        view = apiErrorView
    }

    func displayLoadingView() {
        navigationItem.rightBarButtonItem?.enabled = false
        self.title = Translation.loading
        view = loadingView
    }

    func displayNoContentView() {
        navigationItem.rightBarButtonItem?.enabled = true
        self.title = Translation.informationNotFound
        view = noContentView
    }

    func displayCollectionView() {
        navigationItem.rightBarButtonItem?.enabled = true
        navigationController?.hidesBarsOnSwipe = true
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
        if data.count == 0 {
            displayNoContentView()
        } else {
            displayCollectionView()
            trendingListDataProvider?.trendingListDataManager = trendingListDataManager
            trendingListDataProvider?.trendingListDataManager?.lists = data
            trendingListDataProvider?.navigationController = navigationController
            collectionView.reloadData()
        }
        NetworkManager.networkActivityIndicatorNotVisible()
    }
    
    func ApiError() {
        displayApiErrorView()
    }
}
