//
//  Backend.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

struct Client {
    static let name = "TraktTV"
}

struct APIKeys {
    static let baseUrl = "https://api.trakt.tv/"
}

struct Methods {
    struct Movie {
        static let trending = "movies/trending"
        static let people = "movies/{slugId}/people"
    }
}

struct URLKeys {
    static let slugID = "slugId"
}

struct Parameter {
    struct Key {
        static let extended = "extended"
    }
    struct Value {
        static let extended = "full,images"
    }
}

struct HTTPMethods {
    static let get = "GET"
}

struct HTTPHeader {
    struct Key {
        static let contentType = "Content-Type"
        static let apiKey = "trakt-api-key"
        static let apiVersion = "trakt-api-version"
    }
    struct Value {
        static let contentType = "application/json"
        static let apiKey = "3129a84ef76ba518dadc8ff907cddf4efd7e315c4f6d483502659ef1b19a4b4a"
        static let apiVersion = "2"
    }
}

struct JSONResponseKeys {
    static let cast = "cast"
    static let crew = "crew"
    static let character = "character"
    static let job = "job"
    static let production = "production"
    static let costume = "costume & make-up"
    static let camera = "camera"
    static let writing = "writing"
    static let art = "art"
    static let sound = "sound"
    static let directing = "directing"

    struct Movie {
        static let title = "movie.title"
        static let tagline = "movie.tagline"
        static let overview = "movie.overview"
        static let trailer = "movie.trailer"
        static let rating = "movie.rating"
        static let genres = "movie.genres"

        struct Ids {
            static let slug = "movie.ids.slug"
        }
        struct Images {
            static let thumb = "movie.images.fanart.thumb"
            static let poster = "movie.images.poster.thumb"
        }
    }
    struct Person {
        static let name = "person.name"
        struct Images {
            static let headshot = "person.images.headshot.thumb"
        }
    }
}

struct JSONErrorKey {
    static let error = "Error"
}

struct JSONErrorValue {
    static let error = "Error"
    static let badRequest = "BadRequest"
    static let unauthorized = "Unauthorized"
    static let noData = "NoData"
    static let authorizationDenied = "Authorization has been denied for this request."
}

