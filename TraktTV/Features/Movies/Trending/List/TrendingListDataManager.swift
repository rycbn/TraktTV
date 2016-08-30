//
//  TrendingListDataManager.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import Alamofire

protocol TrendingListDataManagerDelegate {
    func foundAll(data: [TrendingMovie])
    func ApiError()
}

class TrendingListDataManager {

    var delegate: TrendingListDataManagerDelegate?
    var lists = [TrendingMovie]()
    
    func loadTrendingMovie() {
        let parameters = [Parameter.Key.extended: Parameter.Value.extended]
        let urlString = APIKeys.baseUrl + Methods.Movie.trending
        let headers = [
            HTTPHeader.Key.contentType: HTTPHeader.Value.contentType,
            HTTPHeader.Key.apiVersion: HTTPHeader.Value.apiVersion,
            HTTPHeader.Key.apiKey: HTTPHeader.Value.apiKey
        ]
        
        Alamofire.request(.GET, urlString, parameters: parameters, headers: headers).responseJSON { (response) in
            if let _ = response.result.error {
                self.delegate?.ApiError()
            }
            if let results = response.result.value as? [AnyObject] {
                self.populateTrendingMovieFromJSON(results)
            } else {
                self.delegate?.ApiError()
            }
        }
    }
    
    func populateTrendingMovieFromJSON(results: [AnyObject]) {
        var movies = [Movie]()
        
        for result in results {
            let movie = Movie()
            movie.title = result.valueForKeyPath(JSONResponseKeys.Movie.title) as? String
            movie.slug = result.valueForKeyPath(JSONResponseKeys.Movie.Ids.slug) as? String
            movie.tagline = result.valueForKeyPath(JSONResponseKeys.Movie.tagline) as? String
            movie.overview = result.valueForKeyPath(JSONResponseKeys.Movie.overview) as? String
            movie.rating = result.valueForKeyPath(JSONResponseKeys.Movie.rating) as? NSNumber
            movie.genres = result.valueForKeyPath(JSONResponseKeys.Movie.genres) as? [String]
            movie.thumb = result.valueForKeyPath(JSONResponseKeys.Movie.Images.thumb) as? String
            movie.poster = result.valueForKeyPath(JSONResponseKeys.Movie.Images.poster) as? String
            movies.append(movie)
        }

        lists = movies.map { dictionary in
            return MovieParser.mapElement(dictionary)
        }.sort { $0.title < $1.title }

        delegate?.foundAll(lists)
    }
}