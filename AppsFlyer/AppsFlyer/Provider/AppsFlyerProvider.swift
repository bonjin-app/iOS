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
//        instance.delegate = self
    }
}
