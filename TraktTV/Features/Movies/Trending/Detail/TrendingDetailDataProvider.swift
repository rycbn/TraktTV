//
//  TrendingDetailDataProvider.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

enum Section: Int {
    case cast
    case crew
}

class TrendingDetailDataProvider: NSObject {

    weak var trendingDetailDataManager: TrendingDetailDataManager?
    weak var tableView: UITableView?

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
// MARK:- UITableViewDataSource
extension TrendingDetailDataProvider: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let  trendingDetailDataManager = trendingDetailDataManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else { fatalError() }

        let numberOfRows: Int

        switch itemSection {
        case .cast:
            numberOfRows = trendingDetailDataManager.castLists.count
        case .crew:
            numberOfRows = trendingDetailDataManager.crewLists.count
        }

        return numberOfRows
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        guard let itemSection = Section(rawValue: section) else { fatalError() }

        let header: String

        switch itemSection {
        case .cast:
            header = Translation.allCast
        case .crew:
            header = Translation.allCrew
        }

        return header
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(Identifier.trendingDetailTableViewCell) as! TrendingDetailTableViewCell
    }
}
// MARK:- UITableViewDelegate
extension TrendingDetailDataProvider: UITableViewDelegate {

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        guard let cell = cell as? TrendingDetailTableViewCell else { fatalError() }
        guard let trendingDetailDataManager = trendingDetailDataManager else { fatalError() }
        guard let itemSection = Section(rawValue: indexPath.section) else { fatalError() }

        switch itemSection {
        case .cast:
            let itemCast = trendingDetailDataManager.castLists[indexPath.row]

            cell.configureCastCell(itemCast.character, name: itemCast.name)

            if let headshot = itemCast.headshot {
                if let image = itemCast.image {
                    cell.configureHeadshotImageView(image)
                } else {
                    if itemCast.task == nil {
                        cell.configureHeadshotImageView(nil)
                        itemCast.task = self.downloader.download(headshot) { [weak self] url in
                            itemCast.task = nil
                            if url == nil { return }
                            guard let data = NSData(contentsOfURL: url) else {return}
                            let image = UIImage(data: data)
                            itemCast.image = image
                            dispatch_async(dispatch_get_main_queue()) {
                                self?.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                            }
                        }
                    }
                }
            } else {
                let placeholderImage = UIImage(named: ImageName.photoPlaceholder)
                cell.configureHeadshotImageView(placeholderImage)
            }
        case .crew:
            let itemCrew = trendingDetailDataManager.crewLists[indexPath.row]

            cell.configureCrewCell(itemCrew.job, name: itemCrew.name)

            if let headshot = itemCrew.headshot {
                if let image = itemCrew.image {
                    cell.configureHeadshotImageView(image)
                } else {
                    if itemCrew.task == nil {
                        cell.configureHeadshotImageView(nil)
                        itemCrew.task = self.downloader.download(headshot) { [weak self] url in
                            itemCrew.task = nil
                            if url == nil { return }
                            guard let data = NSData(contentsOfURL: url) else {return}
                            let image = UIImage(data: data)
                            itemCrew.image = image
                            dispatch_async(dispatch_get_main_queue()) {
                                self?.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                            }
                        }
                    }
                }
            } else {
                let placeholderImage = UIImage(named: ImageName.photoPlaceholder)
                cell.configureHeadshotImageView(placeholderImage)
            }
        }
    }

    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let trendingDetailDataManager = trendingDetailDataManager else { fatalError() }
        guard let itemSection = Section(rawValue: indexPath.section) else { fatalError() }

        switch itemSection {
        case .cast:
            let itemCast = trendingDetailDataManager.castLists[indexPath.row]
            if let task = itemCast.task {
                if task.state == .Running {
                    task.cancel()
                    itemCast.task = nil
                }
            }
        case .crew:
            let itemCrew = trendingDetailDataManager.crewLists[indexPath.row]
            if let task = itemCrew.task {
                if task.state == .Running {
                    task.cancel()
                    itemCrew.task = nil
                }
            }
        }
    }
}

