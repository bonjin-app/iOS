//
//  ViewController.swift
//  ImagePicker
//
//  Created by gigas on 2021/06/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pressCameraButton(_ sender: Any) {
        print("pressCameraButton")
    }
    
    @IBAction func pressImageLoadButton(_ sender: Any) {
        print("pressImageLoadButton")
    }
    
    @IBAction func pressVideoButton(_ sender: Any) {
        print("pressVideoButton")
    }
    
    @IBAction func pressVideoLoadButton(_ sender: Any) {
        print("pressVideoLoadButton")
    }
}

