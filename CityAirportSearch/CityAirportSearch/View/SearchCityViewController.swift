//
//  SearchCityViewController.swift
//  CityAirportSearch
//
//  Created by gigas on 2021/05/04.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCityViewController: UIViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchCityViewPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

