//
//  TrendingCast.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

class TrendingCast {
    let character: String
    let name: String
    let headshot: String?
    var task: NSURLSessionTask?
    var image: UIImage?

    init(character: String, name: String, headshot: String? = nil) {
        self.character = character
        self.name = name
        self.headshot = headshot
    }
}