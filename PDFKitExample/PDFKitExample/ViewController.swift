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
    
    var pageInfoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    var currentPageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
    private var pdfDocument: PDFDocument?
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        initDocument()
    }
    
    deinit {
        timer?.invalidate()
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

// MARK: - PDFView PDFViewPageChanged
extension ViewController {
    @objc
    func handlePageChange() {
        view.bringSubviewToFront(currentPageLabel)
        if let currentPage: PDFPage = pdfView.currentPage,
           let pageIndex: Int = pdfView.document?.index(for: currentPage) {
            UIView.animate(withDuration: 0.5, animations: {
                self.pageInfoContainer.alpha = 1
            }) { (finished) in
                if finished {
                    self.startTimer()
                }
            }
            currentPageLabel.text = "\(pageIndex + 1) of \(pdfView.document?.pageCount ?? .zero)"
        }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(whenTimerEnds), userInfo: nil, repeats: false)
    }

    @objc
    func whenTimerEnds() {
        UIView.animate(withDuration: 1) {
            self.pageInfoContainer.alpha = 0
        }
    }
}

extension ViewController {
    func setUpUI() {
        view.addSubview(pageInfoContainer)
        
        pageInfoContainer.addSubview(currentPageLabel)
        
        NSLayoutConstraint.activate([
            pageInfoContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pageInfoContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            currentPageLabel.topAnchor.constraint(equalTo: pageInfoContainer.topAnchor, constant: 5),
            currentPageLabel.leadingAnchor.constraint(equalTo: pageInfoContainer.leadingAnchor, constant: 10),
            currentPageLabel.trailingAnchor.constraint(equalTo: pageInfoContainer.trailingAnchor, constant: -10),
            currentPageLabel.bottomAnchor.constraint(equalTo: pageInfoContainer.bottomAnchor, constant: -5),
        ])
    }
    
    func initDocument() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange), name: .PDFViewPageChanged, object: nil)
        
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
}

