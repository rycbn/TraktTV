//
//  ButtonExtension.swift
//  TraktTV
//
//  Created by Roger Yong on 21/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    override public func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        let relativeFrame = self.bounds
        let hitTestEdgeInsets = UIEdgeInsetsMake(-44, -44, -44, -44)
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets)
        return CGRectContainsPoint(hitFrame, point)
    }
}