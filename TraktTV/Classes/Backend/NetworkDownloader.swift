//
//  Downloader.swift
//  TraktTV
//
//  Created by Roger Yong on 22/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

class Wrapper<T> {
    let p:T
    init(_ p:T){self.p = p}
}

// must be @objc_block or we won't get memory management on background thread
typealias NetworkDownloaderCompletion = @convention(block) (NSURL!) -> ()

class NetworkDownloader: NSObject, NSURLSessionDownloadDelegate {
    let config : NSURLSessionConfiguration
    let q = NSOperationQueue()
    let main = true // try false to move delegate methods onto a background thread

    lazy var session : NSURLSession = {
        let queue = (self.main ? NSOperationQueue.mainQueue() : self.q)
        return NSURLSession(configuration:self.config, delegate:self, delegateQueue:queue)
    }()

    deinit {
        print("Deinit from NetworkDownloader")
    }

    init(configuration config:NSURLSessionConfiguration) {
        self.config = config
        super.init()
    }

    func download(s:String, completionHandler ch : NetworkDownloaderCompletion) -> NSURLSessionTask {
        let url = NSURL(string:s)!
        let req = NSMutableURLRequest(URL:url)
        NSURLProtocol.setProperty(Wrapper(ch), forKey:"ch", inRequest:req)
        let task = self.session.downloadTaskWithRequest(req)
        task.resume()
        return task
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten writ: Int64, totalBytesExpectedToWrite exp: Int64) {
        //print("downloaded \(100*writ/exp)%")
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        //print("did resume")
    }

    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let req = downloadTask.originalRequest!
        let ch : AnyObject = NSURLProtocol.propertyForKey("ch", inRequest:req)!
        let response = downloadTask.response as! NSHTTPURLResponse
        let stat = response.statusCode
        //print("status \(stat)")
        var url : NSURL! = nil

        if stat == 200 {
            url = location
            //print("download \(req.URL!.lastPathComponent)")
        }

        let ch2 = (ch as! Wrapper).p as NetworkDownloaderCompletion

        if self.main {
            ch2(url)
        } else {
            dispatch_sync(dispatch_get_main_queue()) {
                ch2(url)
            }
        }
    }
    
    func cancelAllTasks() {
        self.session.invalidateAndCancel()
    }
}