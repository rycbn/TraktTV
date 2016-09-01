//
//  NetworkManager.swift
//  TraktTV
//
//  Created by Roger Yong on 30/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import Alamofire

let parameters = [Parameter.Key.extended: Parameter.Value.extended]
let headers = [
    HTTPHeader.Key.contentType: HTTPHeader.Value.contentType,
    HTTPHeader.Key.apiVersion: HTTPHeader.Value.apiVersion,
    HTTPHeader.Key.apiKey: HTTPHeader.Value.apiKey
]

class NetworkManager {

    class func networkActivityIndicatorVisible() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    class func networkActivityIndicatorNotVisible() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    class func getTrendingMoviesFromAPI(success: ([AnyObject] -> Void), failure: (ErrorType -> Void)) {

        let urlString = APIKeys.baseUrl + Methods.Movie.trending

        Alamofire.request(.GET, urlString, parameters: parameters, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                dispatch_async(dispatch_get_main_queue()) {
                    failure(error)
                }
            }
            if let results = response.result.value as? [AnyObject] {
                dispatch_async(dispatch_get_main_queue()) {
                    success(results)
                }
            }
        }
    }

    class func getCastAndCrewFromAPI(slug: String, success: ([String: AnyObject] -> Void), failure: (ErrorType -> Void)) {

        let methods = subtituteKeyInMethod(Methods.Movie.people, key: URLKeys.slugID, value: slug)
        let urlString = APIKeys.baseUrl + methods

        Alamofire.request(.GET, urlString, parameters: parameters, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                dispatch_async(dispatch_get_main_queue()) {
                    failure(error)
                }
            }
            if let results = response.result.value as? [String: AnyObject] {
                dispatch_async(dispatch_get_main_queue()) {
                    success(results)
                }
            }
        }
    }

    class func getImageFromUrl(urlString: String, success: (UIImage -> Void)) {
        Alamofire.request(.GET, urlString).responseData { (response) in
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            dispatch_async(dispatch_get_main_queue()) {
                success(image)
            }
        }
    }
}