//
//  RawRepresentableTests.swift
//  Test
//
//  Created by Yume on 2017/11/22.
//  Copyright © 2017年 Yume. All rights reserved.
//

import XCTest
@testable import JSONDecodeKit

//{
//    "array": {
//        "primitive":[1,2,3],
//        "decodeable":[{"res":1},{"res":2},{"res":3},],
//    },
//    "dic": {
//        "primitive":{
//            "a":1,
//            "b":2,
//            "c":3,
//            "d": null,
//            "f": 5.5,
//        },
//        "decodeable":{
//            "a":{"res":1},
//            "b":{"res":2},
//            "c":{"res":3},
//        },
//    },
//    "dicArray": {
//        "primitive":{
//            "a":[1,2],
//            "b":[2,3],
//            "c":[3,4],
//        },
//        "decodeable":{
//            "a":[{"res":1},{"res":2},],
//            "b":[{"res":2},{"res":3},],
//            "c":[{"res":3},{"res":4},],
//        },
//    }
//}

class RawRepresentableTests: XCTestCase {
    
    private static var bundle: Bundle { return Bundle(for: self) }
    private static var data: Data {
        let path = bundle.url(forResource: "test2", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }
    
    override class func setUp() {
        super.setUp()
        _ = data
    }
    
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
        
        XCTAssertEqual(TestTarget.a, try! TestTarget.decode(json: JSON(any: 1)))
    }
    
    func testString() {
        typealias TestTarget = EnumString
        XCTAssertEqual(TestTarget.a, try! TestTarget.decode(any: "a"))
        XCTAssertEqual(TestTarget.b, try! TestTarget.decode(any: "b"))
        XCTAssertEqual(TestTarget.c, try! TestTarget.decode(any: "C"))
        XCTAssertNil(try? TestTarget.decode(any: "c"))
    }
    
    func testOperator() {
        let json = JSON(data: RawRepresentableTests.data)
        
        //    "dicArray": {
        //        "primitive":{
        //            "a":[1,2],
        let array: [ResInt] = json["dicArray"]["primitive"] <|| "a"
        XCTAssertEqual(2, array.count)
        
        //    "dic": {
        //        "primitive":{
        //            "a":1,
        let i: ResInt = try! json["dic"]["primitive"] <| "a"
        XCTAssertEqual(ResInt.a, i)
        
        let optI: ResInt? = json["dic"]["primitive"] <|? "a"
        XCTAssertEqual(ResInt.a, optI)
        
    }
}
