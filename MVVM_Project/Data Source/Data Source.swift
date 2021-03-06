//
//  Data Source.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation
import UIKit

public class TableViewDataSource<Cell :UITableViewCell,ViewModel> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    public var configureCell :(Cell,ViewModel) -> ()
   
    
    public init(cellIdentifier :String,tableView:UITableView ,items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell

    }
  
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}



public class CollectionViewDataSource<Cell:UICollectionViewCell, ViewModel> : NSObject , UICollectionViewDataSource {
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    public var configureCell :(Cell,ViewModel) -> ()
    

    public init(cellIdentifier :String,collectionView:UICollectionView ,items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        collectionView.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
}

























