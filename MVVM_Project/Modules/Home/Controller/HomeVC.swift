//
//  ViewController.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import UIKit
import Foundation

class HomeVC: UITableViewController {

    private var dataSource : TableViewDataSource<UITableViewCell,HomeViewModel>!
    private var homeListViewModel : HomeListViewModel?
    private var webservice = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        setupTableViewDataSource()
    }

    private func setupTableViewDataSource(){
     
        self.homeListViewModel =  HomeListViewModel(webservice: webservice) {
            guard let items = self.homeListViewModel?.homeViewModel else {return}
            self.dataSource = TableViewDataSource(cellIdentifier: "cell", tableView: self.tableView, items: items) { cell, viewModel in
                cell.textLabel?.text = viewModel.name
            }
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
      
    }
 
}

