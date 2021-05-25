//
//  ViewController.swift
//  IDFA
//
//  Created by gigas on 2021/05/25.
//

import UIKit
import AppTrackingTransparency

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTrackingAuthorization()
    }
    
    func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .authorized:
                    print("authorized")
                case .denied:
                    print("denied")
                case .notDetermined:
                    print("notDetermined")
                case .restricted:
                    print("restricted")
                }
            }
        }
    }
}

