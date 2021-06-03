//
//  ViewController.swift
//  AppsFlyer
//
//  Created by gigas on 2021/06/03.
//

import UIKit
import AppTrackingTransparency

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in }
        }
    }
    
    @IBAction func btnActionAppLink(_ sender: Any) {
        
//        let url = URL(string: "esbank0001://")
        let url = URL(string: "ibkscheme0001://")

        UIApplication.shared.open(url!) { (result) in
            if result {
               // The URL was delivered successfully!
            }
        }
        
//
////        let urlString = "ibkscheme0001://"
//        let urlString = "esbank0001:"
//        guard let moveURL = URL(string: urlString) else {
//            return //be safe
//        }
//
//        if UIApplication.shared.canOpenURL(moveURL) {
//            UIApplication.shared.open(moveURL, options: [:]) { (Bool) in}
//        } else {
//            guard let storeURL = URL(string: "itms-apps://itunes.apple.com/kr/app/apple-store/id1559855381") else {
//                return //be safe
//            }
//            UIApplication.shared.open(storeURL, options: [:]) { (Bool) in}
//        }
    }
    
}

