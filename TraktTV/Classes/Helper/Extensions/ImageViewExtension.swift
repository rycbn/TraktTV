//
//  ImageViewExtension.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        NetworkManager.getImageFromUrl(urlString) { [weak self] (image) in
            self?.image = image.decompressedImage
        }
    }
}