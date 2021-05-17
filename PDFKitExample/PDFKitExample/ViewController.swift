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
        
        let urlStrings = ["http://www.africau.edu/images/default/sample.pdf",
                         "http://www.africau.edu/images/default/sample.pdf",
                         "http://www.africau.edu/images/default/sample.pdf"]
        
        let documents = urlStrings.compactMap { (urlString) -> PDFDocument? in
            if let url = URL(string: urlString),
               let document = PDFDocument(url: url) {
                return document
            }
            return nil
        }
        loadMultiplePdfView(inputDocuments: documents)
    }
    
    func loadMultiplePdfView(inputDocuments: [PDFDocument]) {
        let document: PDFDocument = PDFDocument()
        var pageIndex: Int = .zero
        for input in inputDocuments {
            for i in .zero...input.pageCount {
                if let page: PDFPage = input.page(at: i) {
                    pageIndex += pageIndex
                    document.insert(page, at: pageIndex)
                }
            }
        }
        
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = document
    }
    
    func loadPdfView(document: PDFDocument) {
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.document = document
    }
}

