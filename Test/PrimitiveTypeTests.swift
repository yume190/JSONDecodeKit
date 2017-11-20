//
//  PrimitiveTypeTests.swift
//  JsonTest
//
//  Created by Yume on 2016/11/7.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
@testable import JSONDecodeKit

class PrimitiveTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testPrimitiveType() {
        // Bool
        XCTAssertEqual(true, Bool.decode(any: true))
        XCTAssertEqual(true, Bool.decode(any: "true"))
        XCTAssertEqual(false, Bool.decode(any: false))
        XCTAssertEqual(false, Bool.decode(any: "false"))
        XCTAssertNil(Bool.decode(any: nil))
        
        // Int
        XCTAssertEqual(1, Int.decode(any: 1))
        XCTAssertEqual(1, Int.decode(any: "1"))
        XCTAssertEqual(-1, Int.decode(any: -1))
        XCTAssertEqual(-1, Int.decode(any: "-1"))
        XCTAssertNil(Int.decode(any: nil))
        
        // String
        XCTAssertEqual("1", String.decode(any: 1))
        XCTAssertEqual("true", String.decode(any: true))
        XCTAssertEqual("1.2", String.decode(any: 1.2))
        XCTAssertNil(String.decode(any: nil))       
    }
    
}
