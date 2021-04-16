//
//  MessageProvider.swift
//  fcm
//
//  Created by gigas on 2021/04/16.
//

import UIK
import Foundation
import Firebase
import UserNotifications

class MessageProvider {
    
    static let shared = { MessageProvider() }()
    
    init() {
        print("FirebaseProvider init")
        
        FirebaseApp.configure()
        
        refreshToken()
    }
    
    func configure(_ appDelegate: AppDelegate, application: UIApplication) {
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = appDelegate
        // [END set_messaging_delegate]
        
        // [START register_for_notifications]
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = appDelegate
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
        // [END register_for_notifications]
    }
    
    // Refresh Token
    func refreshToken() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
                
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
    }
}

extension AppDelegate: MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
}
