//
//  AppDelegate.swift
//  AppsFlyer
//
//  Created by gigas on 2021/06/03.
//

import UIKit
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard
    
    //MARK: LifeCycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppsFlyerProvider.shared.setDelegate(delegate: self)
        
        // iOS 10 or later
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
            application.registerForRemoteNotifications()
        }
        // iOS 9 support - Given for reference. This demo app supports iOS 13 and above
        else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            application.registerForRemoteNotifications()
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Start the SDK (start the IDFA timeout set above, for iOS 14 or later)
        AppsFlyerProvider.shared.start()
    }
    
    // Open Univerasal Links
    // For Swift version < 4.2 replace function signature with the commented out code:
    // func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(" user info \(userInfo)")
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    // Open Deeplinks
    // Open URI-scheme for iOS 8 and below
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
    
    // Open URI-scheme for iOS 9 and above
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    // Report Push Notification attribution data for re-engagements
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    // Reports app open from deep link for iOS 10 or later
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
}

// MARK: - AppsFlyerLibDelegate
extension AppDelegate: AppsFlyerLibDelegate{
    
    // MARK: - Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        AppsFlyerProvider.shared.onConversionDataSuccess(installData)
    }
    
    func onConversionDataFail(_ error: Error) {
        AppsFlyerProvider.shared.onConversionDataFail(error)
    }
    
    // MARK: - Handle Deep Link
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        AppsFlyerProvider.shared.onAppOpenAttribution(attributionData)
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        AppsFlyerProvider.shared.onAppOpenAttributionFailure(error)
    }
}
