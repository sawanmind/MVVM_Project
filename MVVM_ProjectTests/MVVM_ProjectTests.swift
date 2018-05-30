//
//  MVVM_ProjectTests.swift
//  MVVM_ProjectTests
//
//  Created by iOS Development on 5/30/18.
//  Copyright © 2018 Smartivity. All rights reserved.
//

import XCTest
@testable import MVVM_Project

class MVVM_ProjectTests: XCTestCase {
    
    func testapp(){
        let vc = HomeVC(style: .grouped)
        let value = Int(arc4random())
        XCTAssertTrue(vc.demo(value: value))
        
    }
    
}
