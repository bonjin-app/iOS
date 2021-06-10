//
//  ViewController.swift
//  ImagePicker
//
//  Created by gigas on 2021/06/10.
//

import AVFoundation
import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var flagImageSave: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }

    @IBAction func pressCameraButton(_ sender: Any) {
        print("pressCameraButton")
        flagImageSave = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            presentPhotoPicker(sourceType: .camera)
            
        } else {
            showAlert("Camera inaccessble", message: "Application cannot access the camera")
        }
    }
    
    @IBAction func pressPhotoLibraryButton(_ sender: Any) {
        print("pressImageLoadButton")
        flagImageSave = false
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            presentPhotoPicker(sourceType: .photoLibrary)
            
        } else {
            showAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
}

/**
 + Privacy - Camera Usage Description
 + Privacy - Photo Library Usage Description
 + Privacy - Microphone Usage Description
 
 imagePicker.mediaTypes = [kUTTypeImage as String]
 imagePicker.mediaTypes = [kUTTypeMovie as String]
 or
 imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
 */
extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imagePickerController didFinishPickingMediaWithInfo")
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType.isEqual(kUTTypeImage as String) {
            let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            imageView.image = captureImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
        } else if mediaType.isEqual(kUTTypeMovie as String) {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            imageView.image = videoSnapshot(path: videoURL.relativePath)
            
            if flagImageSave {
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel")
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController {
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
        present(imagePicker, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String, message: String) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func videoSnapshot(path: String) -> UIImage? {
        let url = URL(fileURLWithPath: path)
        let asset = AVURLAsset(url: url as URL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        do {
            let image = try generator.copyCGImage(at: timestamp, actualTime: nil)
            return UIImage(cgImage: image)
            
        } catch {
            print("Image generation failed with error \(error)")
            return nil
        }
    }
}
