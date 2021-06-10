//
//  ViewController.swift
//  ImagePicker
//
//  Created by gigas on 2021/06/10.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var captureImage: UIImage! = nil
    var videoURL: URL! = nil
    var flagImageSave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    @IBAction func pressCameraButton(_ sender: Any) {
        print("pressCameraButton")
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            showAlert("Camera inaccessble", message: "Application cannot access the camera")
        }
    }
    
    @IBAction func pressImageLoadButton(_ sender: Any) {
        print("pressImageLoadButton")
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            showAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func pressVideoButton(_ sender: Any) {
        print("pressVideoButton")
    }
    
    @IBAction func pressVideoLoadButton(_ sender: Any) {
        print("pressVideoLoadButton")
    }
}

/**
 + Privacy - Camera Usage Description
 + Privacy - Photo Library Usage Description
 */
extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController didFinishPickingMediaWithInfo")
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            imageView.image = captureImage
            
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String) {
            videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
            UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    func showAlert(_ title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
}
