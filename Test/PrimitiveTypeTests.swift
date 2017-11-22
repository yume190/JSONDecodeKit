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
    
    
    // Mark: Bool
    func testBool() {
        typealias TestTarget = Bool
        XCTAssertEqual(true, try! TestTarget.decode(any: true))
        XCTAssertEqual(true, try! TestTarget.decode(any: "true"))
        XCTAssertEqual(false, try! TestTarget.decode(any: false))
        XCTAssertEqual(false, try! TestTarget.decode(any: "false"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    
    // Mark: Int
    func testInt8() {
        typealias TestTarget = Int8
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0x7F))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 127))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0x80))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: -128))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    func testInt16() {
        typealias TestTarget = Int16
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0x7FFF))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 32767))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0x8000))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: -32768))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }

    func testInt32() {
        typealias TestTarget = Int32
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0x7FFFFFFF))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 2147483647))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0x80000000))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: -2147483648))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }

    func testInt64() {
        typealias TestTarget = Int64
        // upper bound
        let max:TestTarget = 0x7FFFFFFF_FFFFFFFF
//        let min:TestTarget = 0x80000000_00000000
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: max))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
//        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: min))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    
    // Mark: UInt
    func testUInt8() {
        typealias TestTarget = UInt8
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0xFF))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }

    func testUInt16() {
        typealias TestTarget = UInt16
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0xFFFF))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }

    func testUInt32() {
        typealias TestTarget = UInt32
        // upper bound
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: 0xFFFFFFFF))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }

    func testUInt64() {
        typealias TestTarget = UInt64
        // upper bound
        let max:TestTarget = 0xFFFFFFFF_FFFFFFFF
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: max))
        XCTAssertEqual(TestTarget.max, try! TestTarget.decode(any: TestTarget.max))
        // lower bound
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: 0))
        XCTAssertEqual(TestTarget.min, try! TestTarget.decode(any: TestTarget.min))
        
        XCTAssertEqual(1, try! TestTarget.decode(any: "1"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    
    // MARK: Float
    func testFloat() {
        typealias TestTarget = Float
        XCTAssertEqual(1.0, try! TestTarget.decode(any: 1.0))
        XCTAssertEqual(1.0, try! TestTarget.decode(any: "1.0"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    func testDouble() {
        typealias TestTarget = Double
        XCTAssertEqual(1.0, try! TestTarget.decode(any: 1.0))
        XCTAssertEqual(1.0, try! TestTarget.decode(any: "1.0"))
        XCTAssertNil(try? TestTarget.decode(any: nil))
    }
    
    func testString() {
        XCTAssertEqual("1", try! String.decode(any: 1))
        XCTAssertEqual("true", try! String.decode(any: true))
        XCTAssertEqual("1.2", try! String.decode(any: 1.2))
        XCTAssertNil(try? String.decode(any: nil))
    }
 
    //extension URL:PrimitiveType {}
    
}

