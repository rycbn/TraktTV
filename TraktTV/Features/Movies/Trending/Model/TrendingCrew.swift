//
//  TrendingCrew.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class TrendingCrew {
    let job: String
    let name: String
    let headshot: String?
    var task: NSURLSessionTask?
    var image: UIImage?

    init(job: String, name: String, headshot: String? = nil) {
        self.job = job
        self.name = name
        self.headshot = headshot
    }
}