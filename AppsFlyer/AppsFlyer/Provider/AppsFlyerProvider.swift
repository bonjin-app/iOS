//
//  AppsFlyerProvider.swift
//  AppsFlyer
//
//  Created by gigas on 2021/06/03.
//

import Foundation
import AppsFlyerLib

class AppsFlyerProvider {
    
    static let shared = { AppsFlyerProvider() }()
    private let instance: AppsFlyerLib
    private let _devKey = "o27KAdr4W2Ch6JjpyG5PeL"
    private let _appleAppId = "F8J465D99R"
    
    init() {
        print("AppsFlyerProvider init")
        
        instance = AppsFlyerLib.shared()
        instance.appsFlyerDevKey = _devKey
        instance.appleAppID = _appleAppId
        instance.isDebug = true
//        instance.delegate = self
        instance.waitForATTUserAuthorization(timeoutInterval: 60)
    }
    
    func setDelegate(delegate: AppDelegate) {
        instance.delegate = delegate
    }
    
    func start() {
        instance.start()
    }
    
    // 신규 설치에 대한 전환 데이터를 제공
    // MARK: - Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in installData {
            print(key, ":", value)
        }
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = installData["media_source"],
                    let campaign = installData["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = installData["is_first_launch"] as? Bool,
                is_first_launch {
                print("First Launch")
            } else {
                print("Not First Launch")
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        print("onConversionDataFail error:")
        print(error)
    }
    
    // 이미 설치되어 있는 앱이 수동이나 딥링킹을 통해 실행되었을 때, 리타겟팅 전환 데이터를 제공
    // MARK: - Handle Deep Link
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("onAppOpenAttribution data:")
        for (key, value) in attributionData {
            print(key, ":",value)
        }
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print("onAppOpenAttributionFailure error:")
        print(error)
    }
}
