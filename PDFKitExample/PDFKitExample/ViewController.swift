//
//  ViewController.swift
//  PDFKitExample
//
//  Created by gigas on 2021/05/17.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    
    var pdfDocument: PDFDocument?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://www.africau.edu/images/default/sample.pdf"
        if let url = URL(string: urlString),
           let document = PDFDocument(url: url) {
            loadPdfView(document: document)
        }
    }
    
    func loadPdfView(document: PDFDocument) {
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = document
        
        self.pdfDocument = document
    }
}

