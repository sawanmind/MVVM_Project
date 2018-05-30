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
    private var placeholder = Placeholder()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        placeholder.delegate = self
        self.view.addSubview(placeholder)
        setupTableViewDataSource()
    }
   
    func demo(value:Int) -> Bool{
        if value % 2 == 0 {
            return true
        }
        return false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
    }

    
    
 
}

extension HomeVC: PlaceholderDelegate {
    func didTapTryAgain() {
        if (self.homeListViewModel?.homeViewModel.isEmpty)! {
            setupTableViewDataSource()
        }
    }
    

    
    private func setupTableViewDataSource(){
      
        self.homeListViewModel =  HomeListViewModel(webservice: webservice) {
            guard let items = self.homeListViewModel?.homeViewModel else {return}
            self.dataSource = TableViewDataSource(cellIdentifier: "cell", tableView: self.tableView, items: items) { cell, viewModel in
                cell.textLabel?.text = viewModel.name
            }
            if self.homeListViewModel?.homeViewModel.count != 0 {
                 self.placeholder._isHidden.value = true
            } else {
                 self.placeholder._isHidden.value = false
            }
          
            self.placeholder.delegate?.getView(view: self.tableView)
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
        
    }
}

