//
//  ViewController.swift
//  FileUpload
//
//  Created by gigas on 2021/06/09.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressUploadButton(_ sender: Any) {
        performFileUpload()
    }
}

extension ViewController {
    func performFileUpload() {
        
        do {
            
            // ImagePicker
//            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
//            let fileData = try? Data(contentsOf: videoURL, options: .mappedIfSafe)
            
            // 로컬 파일
//            let fileUrl = Bundle.main.url(forResource: "Sample", withExtension: "mp4")
            
            // 원격 파일
            let fileUrl = URL(string: "https://thumbs.gfycat.com/DistantTameAmericanwarmblood-mobile.mp4")
            let fileData = try? Data(contentsOf: fileUrl!)
            let mimeType = fileUrl?.mimeType
            let fileName = "Sample.mp4"
            let parameters: [String:String] = [
                "email": "bonjin.app@gmail.com",
                "team": "bonjin",
                "name": "gigas",
            ]
            
            FileUploadProvider.shared.requestFileUploadAlamofire(parameters: parameters,
                              fileData: fileData ?? Data(),
                              fileName: fileName,
                              mimeType: mimeType ?? "",
                              progressHandler: uploadProgress,
                              successHandler: { response in
                                if let data = response.data {
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
