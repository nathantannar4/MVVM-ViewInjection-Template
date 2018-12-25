//
//  AppViewModel.swift
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class AppViewModel: NSObject, IViewModel {

    // MARK: - Properties
    
    var appDisplayName: String? {
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }

    var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    var applicationIconBadgeNumber: Int {
        get { return UIApplication.shared.applicationIconBadgeNumber }
        set { UIApplication.shared.applicationIconBadgeNumber = newValue }
    }

    var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var batteryLevel: Float {
        return UIDevice.current.batteryLevel
    }

    var currentDevice: UIDevice {
        return UIDevice.current
    }

    var deviceModel: String {
        return currentDevice.modelName
    }

    var deviceName: String {
        return currentDevice.name
    }

    var deviceOrientation: UIDeviceOrientation {
        return currentDevice.orientation
    }

    var isInDebuggingMode: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }

    var isInTestFlight: Bool {
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }

    var isNetworkActivityIndicatorVisible: Bool {
        get { return UIApplication.shared.isNetworkActivityIndicatorVisible }
        set { UIApplication.shared.isNetworkActivityIndicatorVisible = newValue }
    }

    var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }

    var isRunningOnSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    // MARK: - Init

    override init() {
        super.init()
        viewModelDidLoad()
    }

    func viewModelDidLoad() {

    }

    // MARK: - Methods

    func route(to route: Route) {
        AppRouter.shared.navigate(to: route)
    }
}
