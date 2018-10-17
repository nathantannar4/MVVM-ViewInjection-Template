//
//  UIApplication+Extensions.swift
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SystemConfiguration

extension UIApplication {
  
    /// The top most window in UIApplication.shared.windows that is presenting a view
    var presentedWindow: UIWindow? {
        for window in windows.reversed() {
            if window.windowLevel == UIWindow.Level.normal && !window.isHidden && window.frame != CGRect.zero {
                return window
            }
        }
        return nil
    }
    
    /// The top most presented view controller of the UIApplications presentedWindow
    var presentedController: UIViewController? {
        if var topController = presentedWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        return nil
    }
    
    /// Checks whether the network is reachable.
    ///
    /// The code was obtained from the following URL.
    /// http://stackoverflow.com/questions/39675445/reachability-returns-false-for-cellular-network-in-ios-swift
    ///
    /// - Returns: The reachability of the network, either true or false.
    var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}
