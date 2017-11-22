//
//  RawRepresentableTests.swift
//  Test
//
//  Created by Yume on 2017/11/22.
//  Copyright © 2017年 Yume. All rights reserved.
//

import XCTest

class RawRepresentableTests: XCTestCase {
    
    enum EnumInt:Int {
        case a = 1
        case b = 2
        case c = 3
    }
    
    enum EnumString:String {
        case a
        case b
        case c = "C"
    }
    
    func testInt() {
        typealias TestTarget = EnumInt
        XCTAssertEqual(TestTarget.a, try! TestTarget.decode(any: 1))
        XCTAssertEqual(TestTarget.b, try! TestTarget.decode(any: 2))
        XCTAssertEqual(TestTarget.c, try! TestTarget.decode(any: 3))
        XCTAssertNil(try? TestTarget.decode(any: 4))
    }
    
    func testString() {
        typealias TestTarget = EnumString
        XCTAssertEqual(TestTarget.a, try! TestTarget.decode(any: "a"))
        XCTAssertEqual(TestTarget.b, try! TestTarget.decode(any: "b"))
        XCTAssertEqual(TestTarget.c, try! TestTarget.decode(any: "C"))
        XCTAssertNil(try? TestTarget.decode(any: "c"))
    }
}
