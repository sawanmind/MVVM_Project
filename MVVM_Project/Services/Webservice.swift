//
//  Web Service.swift
//  MVVM_Project
//
//  Created by iOS Development on 3/5/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import Foundation


class WebService {
    func loadData(url:String,completion : @escaping ([HomeModel]) -> ()) {
        
        var sources = [HomeModel]()
        
        let sourceURL = URL(string :url)!
        
        URLSession.shared.dataTask(with: sourceURL) { data, _, _ in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! [String:Any]
                let sourcesDictionary = dictionary["sources"] as! [[String:Any]]
                
                sources = sourcesDictionary.flatMap(HomeModel.init)
                
                DispatchQueue.main.async {
                    completion(sources)
                }
            }
            
            }.resume()
        
    }
}
