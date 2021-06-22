//
//  ViewController.swift
//  JsonCodable
//
//  Created by gigas on 2021/06/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpData()
    }

    private func setUpData() {
        
        let url = "http://210.205.202.28:8080"
        
        AF.request("\(url)/main", method: .post).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let res):
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(MainList.self, from: jsonData)
                    
                    print(json)
                    
                } catch {
                    print(error)
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}

struct MainList: Codable {
    let data: DATAClass
    let resn, rslt: String

    enum CodingKeys: String, CodingKey {
        case data = "DATA"
        case resn = "RESN"
        case rslt = "RSLT"
    }
}

// MARK: - DATAClass
struct DATAClass: Codable {
    let listContentM: [ListContentM]
}

// MARK: - ListContentM
struct ListContentM: Codable {
    let creator, listContentMDescription: String
    let contentMID: Int
    let profileImg: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case creator
        case listContentMDescription = "description"
        case contentMID = "contentMId"
        case profileImg, url
    }
}
