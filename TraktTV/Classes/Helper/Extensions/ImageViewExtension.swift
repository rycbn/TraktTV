//
//  ImageViewExtension.swift
//  TraktTV
//
//  Created by Roger Yong on 19/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        Alamofire.request(.GET, urlString).responseData { (response) in
            guard let data = response.data else { return }
            guard let image = UIImage(data: data) else { return }
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                self?.image = image.decompressedImage
            }
        }
    }
}