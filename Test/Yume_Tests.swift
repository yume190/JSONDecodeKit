//
//  Yume_Tests.swift
//  JsonTest
//
//  Created by Yume on 2016/10/24.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
@testable import JSONDecodeKit

class Yume_Tests: XCTestCase {
    
    func testNonTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        self.measure {
            let myJson = JSON(any: json)
            let programs:[Program] = try! myJson["ProgramList"]["Programs"].array()
            XCTAssert(programs.count > 1000)
        }
    }
    
    func testTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
        self.measure {
            let myJson = JSON(any: json,isTraceKeypath:true)
            let programs:[Program] = try! myJson["ProgramList"]["Programs"].array()
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()

}
