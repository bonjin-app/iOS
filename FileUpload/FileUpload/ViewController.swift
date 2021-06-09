//
//  ViewController.swift
//  FileUpload
//
//  Created by gigas on 2021/06/09.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressUploadButton(_ sender: Any) {
        performFileUpload()
    }
}

extension ViewController {
    func performFileUpload() {
        let filePath = Bundle.main.url(forResource: "test", withExtension: "mp4")
        let mimeType = filePath?.mimeType
        let fileName = "100.mp4"
        let parameters: Parameters = [
            "email": "1",
            "contentMId": "000001"
        ]
        
        do {
            let fileData = try? Data(contentsOf: filePath!)
            requestFileUpload(parameters: parameters,
                           fileData: fileData ?? Data(),
                           fileName: fileName,
                           mimeType: mimeType ?? "")
        }
    }
    
    func requestFileUpload(parameters: Parameters, fileData: Data, fileName: String, mimeType: String) {
        guard let url = URL(string: "/api/upload", relativeTo: Constants.Base.domain.url) else {
            return
        }
        
//        guard let url = URL(string: "/transfer", relativeTo: Constants.Base.domain.url) else {
//            return
//        }
        
        AF.upload(multipartFormData: { multipart in
            for (key, value) in parameters {
                multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            multipart.append(fileData, withName: "files", fileName: fileName, mimeType: mimeType)
            
        }, to: url, method: .post)
        .uploadProgress { progress in
            self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            self.progressLabel.text = "\(progress.fractionCompleted*100)"
            
        }.response { response in
            if let data = response.data {
                print("Response Data: \(data)")
                print("response : \(String(describing: String(data: data, encoding: .utf8)))")
                
            } else {
                print("Something went wrong")
            }
        }
    }
}

