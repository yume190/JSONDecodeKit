//
//  PrimitiveTypeTests.swift
//  JsonTest
//
//  Created by Yume on 2016/11/7.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
import JSONDecodeKit

class PrimitiveTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testPrimitiveType() {
        // Bool
        XCTAssertEqual(true, Bool.decode(true))
        XCTAssertEqual(true, Bool.decode("true"))
        XCTAssertEqual(false, Bool.decode(false))
        XCTAssertEqual(false, Bool.decode("false"))
        XCTAssertNil(Bool.decode(nil))
        
        // Int
        XCTAssertEqual(1, Int.decode(1))
        XCTAssertEqual(1, Int.decode("1"))
        XCTAssertEqual(-1, Int.decode(-1))
        XCTAssertEqual(-1, Int.decode("-1"))
        XCTAssertNil(Int.decode(nil))
        
        // String
        XCTAssertEqual("1", String.decode(1))
        XCTAssertEqual("true", String.decode(true))
        XCTAssertEqual("1.2", String.decode(1.2))
        XCTAssertNil(String.decode(nil))       
    }
    
}
