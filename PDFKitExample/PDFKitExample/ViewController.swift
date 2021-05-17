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
        
        let urlString = "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
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

