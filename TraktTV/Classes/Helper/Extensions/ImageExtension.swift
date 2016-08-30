//
//  ImageExtension.swift
//  TraktTV
//
//  Created by Roger Yong on 26/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage
    }
}
