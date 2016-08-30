//
//  TrendingListDataProvider.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class TrendingListDataProvider: NSObject {
    
    weak var trendingListDataManager: TrendingListDataManager?
    weak var navigationController: UINavigationController?

    lazy var configuration: NSURLSessionConfiguration = {
        $0.allowsCellularAccess = true
        $0.URLCache = nil
        return $0
    }(NSURLSessionConfiguration.ephemeralSessionConfiguration())

    lazy var downloader: NetworkDownloader = {
        return NetworkDownloader(configuration: self.configuration)
    }()

    deinit {
        downloader.cancelAllTasks()
    }
}
// MARK:- UICollectionViewDataSource
extension TrendingListDataProvider: UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = trendingListDataManager?.lists.count else { return 0 }
        return count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(Identifier.trendingListCollectionViewCell, forIndexPath: indexPath) as! TrendingListCollectionViewCell
    }
}
// MARK:- UICollectionViewDelegate
extension TrendingListDataProvider: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

        guard let cell = cell as? TrendingListCollectionViewCell else {
            fatalError("Error with register cell")
        }

        guard let model = trendingListDataManager?.lists[indexPath.item] else {
            fatalError("Error with data manager")
        }

        cell.configureTrendingListCell(model.title, tagline: model.tagline)

        if let image = model.image {
            cell.configureImageView(image)
        } else {
            if model.task == nil {
                cell.configureImageView(nil)
                model.task = downloader.download(model.thumb) { url in
                    model.task = nil
                    if url == nil { return }
                    guard let data = NSData(contentsOfURL: url) else {return}
                    let image = UIImage(data: data)
                    model.image = image
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.configureImageView(model.image)
                    }
                }
            }
        }
    }

    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

        guard let model = trendingListDataManager?.lists[indexPath.item] else {
            fatalError("Error with data manager")
        }

        if let task = model.task {
            if task.state == .Running {
                task.cancel()
                model.task = nil
            }
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        guard let focusViewLayout = collectionView.collectionViewLayout as? TrendingListCollectionViewLayout else {
            fatalError("error casting focus layout from collection view")
        }

        let offset = focusViewLayout.dragOffset * CGFloat(indexPath.item)

        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        } else {
            guard let model = trendingListDataManager?.lists[indexPath.item] else {
                fatalError("Error with data manager")
            }

            let storyboard = UIStoryboard(name: Identifier.main, bundle: NSBundle.mainBundle())
            let viewControler = storyboard.instantiateViewControllerWithIdentifier(Identifier.trendingDetailStoryboardID) as! TrendingDetailViewController
            viewControler.model = model
            //navigationController?.presentViewController(viewControler, animated: true, completion: nil)
            navigationController?.pushViewController(viewControler, animated: true)
        }
    }
}