//
//  Utilities.swift
//  TraktTV
//
//  Created by Roger Yong on 20/08/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import CoreTelephony
import SystemConfiguration

func hasCellularCoverage() -> Bool {
    let carrier = CTCarrier()
    let subscriber = CTSubscriber()
    if !(carrier.mobileCountryCode != nil) { return false }
    if !(subscriber.carrierToken != nil) { return false }

    return true
}

func isReachacbleToInternet() -> Bool {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
        SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }

    var flags = SCNetworkReachabilityFlags()

    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }

    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0

    return (isReachable && !needsConnection)
}

func isNetworkReachableOrHasCellularCoverage() -> Bool {
    return (isReachacbleToInternet() || hasCellularCoverage())
}

func displayAlertWithTitle(title: String?, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: Translation.ok, style: .Cancel, handler: nil)
    alert.addAction(action)

    dispatch_async(dispatch_get_main_queue()) {
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
}

func subtituteKeyInMethod(method: String, key: String, value: String) -> String {
    return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
}

func imageTransition() -> CATransition {
    let transition = CATransition()
    transition.duration = 1.0
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transition.type = kCATransitionFade

    return transition
}