//
//  TrendingMovie.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class TrendingMovie {
    let title: String
    let slug: String
    let tagline: String
    let overview: String
    let rating: NSNumber
    let genres: [String]
    let thumb: String
    let poster: String
    let trailer: String?
    var task: NSURLSessionTask?
    var image: UIImage?

    init(title: String, slug: String, tagline: String, overview: String, rating: NSNumber, genres: [String], thumb: String, poster: String, trailer: String? = nil) {
        self.title = title
        self.slug = slug
        self.tagline = tagline
        self.overview = overview
        self.rating = rating
        self.genres = genres
        self.thumb = thumb
        self.poster = poster
        self.trailer = trailer
    }
}
extension TrendingMovie {
    var formattedRating: String {
        return String(format:"%.1f/10", rating as Float)
    }
    var formattedGenres: String {
        return genres.map( { $0 } ).joinWithSeparator(", ")
    }
}