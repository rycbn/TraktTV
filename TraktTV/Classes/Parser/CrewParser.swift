//
//  CrewParser.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

struct CrewParser: Mapping {
    static func mapElement(element: Crew) -> TrendingCrew {
        guard let job = element.job,
            name = element.name else {
                fatalError("Error when parsing elements")
        }
        return TrendingCrew(job: job, name: name, headshot: element.headshot)
    }
}