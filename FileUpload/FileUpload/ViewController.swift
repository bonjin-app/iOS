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
            FileUploadProvider.shared.requestFileUpload(parameters: parameters,
                              fileData: fileData ?? Data(),
                              fileName: fileName,
                              mimeType: mimeType ?? "",
                              progressHandler: uploadProgress,
                              successHandler: { response in
                                if let data = response.data {
                                    print("Response Data: \(data)")
                                    print("response : \(String(describing: String(data: data, encoding: .utf8)))")
                                    
                                } else {
                                    print("Something went wrong")
                                }
                              })
        }
    }
    
    func uploadProgress(progress: Progress) {
        self.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
        self.progressLabel.text = "\(progress.fractionCompleted*100)"
    }
}

