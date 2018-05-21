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
   
    lazy var errorLabel:UILabel = {
        let instance = UILabel()
        instance.adjustsFontForContentSizeCategory = true
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.systemFont(ofSize: 22.5, weight: UIFont.Weight.black)
        instance.text = "Something went wrong!\nPlease try again later."
        instance.textColor = UIColor.black
        instance.textAlignment = .center
        instance.numberOfLines = 0
        instance.lineBreakMode = .byWordWrapping
        return instance
    }()
    
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        setupTableViewDataSource()
        setupErrorLabel()
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
    }

    
    
 
}

extension HomeVC {
  
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -64).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -40).isActive = true
        errorLabel.heightAnchor.constraint(equalTo: errorLabel.heightAnchor).isActive = true
    }
    
    private func setupTableViewDataSource(){
        
        self.homeListViewModel =  HomeListViewModel(webservice: webservice) {
            guard let items = self.homeListViewModel?.homeViewModel else {return}
            self.dataSource = TableViewDataSource(cellIdentifier: "cell", tableView: self.tableView, items: items) { cell, viewModel in
                cell.textLabel?.text = viewModel.name
            }
            if !(self.homeListViewModel?.homeViewModel.isEmpty)! {
                self.errorLabel.isHidden = true
            }
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
        
    }
}

