//
//  Mapping.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation

protocol Mapping {
    associatedtype Input
    associatedtype Output

    static func mapElement(element: Input) -> Output
}