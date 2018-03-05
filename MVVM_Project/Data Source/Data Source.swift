//
//  Data Source.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Cell :UITableViewCell,ViewModel> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    var configureCell :(Cell,ViewModel) -> ()
    
    
    init(cellIdentifier :String,tableView:UITableView ,items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}


