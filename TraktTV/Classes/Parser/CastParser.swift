//
//  CastParser.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct CastParser: Mapping {
    static func mapElement(element: Cast) -> TrendingCast {
        guard let character = element.character,
            name = element.name else {
                fatalError("Error when parsing elements")
        }
        return TrendingCast(character: character, name: name, headshot: element.headshot)
    }
}