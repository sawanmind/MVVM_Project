//
//  HomeModel.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation


class HomeModel {
    
    var id :String
    var name :String
    var description :String
    
    init(id :String, name :String, description :String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    init(homeViewModel :HomeViewModel) {
        self.id = homeViewModel.id
        self.name = homeViewModel.name
        self.description = homeViewModel.description
    }
    
    init?(dictionary :[String:Any]) {
        
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
    }
}
