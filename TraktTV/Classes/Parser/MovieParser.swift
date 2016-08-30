//
//  MovieParser.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct MovieParser: Mapping {
    static func mapElement(element: Movie) -> TrendingMovie {
        guard let title = element.title,
            slug = element.slug,
            tagline = element.tagline,
            overview = element.overview,
            rating = element.rating,
            genres = element.genres,
            thumb = element.thumb,
            poster = element.poster else {
                fatalError("Error when parsing elements")
        }
        return TrendingMovie(title: title, slug: slug, tagline: tagline, overview: overview, rating: rating, genres: genres, thumb: thumb, poster: poster)
    }
}