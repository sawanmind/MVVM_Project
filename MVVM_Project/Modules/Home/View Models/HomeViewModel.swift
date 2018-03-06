//
//  HomeViewModel.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation


class HomeViewModel {
    
    var id : String
    var name : String
    var description : String
    
    init(source :HomeModel) {
        self.id = source.id
        self.name = source.name
        self.description = source.description
    }
    
    init(id:String, name:String, description:String) {
        self.id = id
        self.name = name
        self.description = description
    }
}



class HomeListViewModel {
    
    private var webservice : WebService
    private (set) var homeViewModel : [HomeViewModel] = [HomeViewModel]()
    private var completion: () -> () = { }
    
    
    init(webservice:WebService, completion:@escaping () -> ()) {
        
        self.webservice = webservice
        self.completion = completion
        populateData()
    }
    
    private func populateData(){
        let url = "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd"
        self.webservice.loadData(url: url) { sources in
            self.homeViewModel = sources.map(HomeViewModel.init)
            self.completion()
        }
    }
    
    func indexAt(index:Int) -> HomeViewModel {
        return self.homeViewModel[index]
    }
}













