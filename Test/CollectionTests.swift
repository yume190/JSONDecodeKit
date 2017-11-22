//
//  JSONDecodableTests.swift
//  JsonTest
//
//  Created by Yume on 2016/11/7.
//  Copyright © 2016年 Yume. All rights reserved.
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


struct Res:JSONDecodable {
    let res:Int
    static func decode(json: JSON) throws -> Res {
        return try Res(res: json <| "res")
    }
}
enum ResInt:Int {
    case a = 1
    case b = 2
    case c = 3
    case d = 4
    case e = 5
}

class DictionaryArrayTests: XCTestCase {
    private lazy var json:JSON = {
        let path = Bundle(for: type(of: self)).url(forResource: "test2", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = JSON(data: data)
        return json
    }()

    // JSON + Array
    func testArrayPrimitive() {
        let target:[Int] = try! json["array"]["primitive"].array()
        XCTAssertEqual(target, [1,2,3])
    }
    
    func testArrayEnum() {
        let target:[ResInt] = json["array"]["primitive"].array()
        XCTAssertEqual(target, [ResInt.a, ResInt.b, ResInt.c])
    }
    
    func testArrayDecodable() {
        let target:[Res] = try! json["array"]["decodeable"].array()
        XCTAssertEqual(target[0].res, 1)
        XCTAssertEqual(target[1].res, 2)
        XCTAssertEqual(target[2].res, 3)
    }
    
    // JSON + Dictionary
    func testDictionaryPrimitive() {
        let target:[String:Int] = json["dic"]["primitive"].dictionary()
        XCTAssertEqual(target["a"], 1)
        XCTAssertEqual(target["b"], 2)
        XCTAssertEqual(target["c"], 3)
    }
    
    func testDictionaryEnum() {
        let target:[String:ResInt] = json["dic"]["primitive"].dictionary()
        XCTAssertEqual(target["a"], ResInt.a)
        XCTAssertEqual(target["b"], ResInt.b)
        XCTAssertEqual(target["c"], ResInt.c)
    }
    
    func testDictionaryDecodable() {
        let target:[String:Res] = json["dic"]["decodeable"].dictionary()
        XCTAssertEqual(target["a"]!.res, 1)
        XCTAssertEqual(target["b"]!.res, 2)
        XCTAssertEqual(target["c"]!.res, 3)
    }

    // JSON + Dictionary+ValueArray
    func testDictionaryArrayPrimitive() {
        let target:[String:[Int]] = json["dicArray"]["primitive"].dictionaryValueArray()
        XCTAssertEqual(target["a"]!, [1,2])
        XCTAssertEqual(target["b"]!, [2,3])
        XCTAssertEqual(target["c"]!, [3,4])
    }
    
    func testDictionaryyArrayEnum() {
        let target:[String:[ResInt]] = json["dicArray"]["primitive"].dictionaryValueArray()
        XCTAssertEqual(target["a"]!, [ResInt.a,ResInt.b])
        XCTAssertEqual(target["b"]!, [ResInt.b,ResInt.c])
        XCTAssertEqual(target["c"]!, [ResInt.c,ResInt.d])
    }
    
    func testDictionaryyArrayDecodable() {
        let target:[String:[Res]] = json["dicArray"]["decodeable"].dictionaryValueArray()
        XCTAssertEqual(target["a"]![0].res, 1)
        XCTAssertEqual(target["a"]![1].res, 2)
        XCTAssertEqual(target["b"]![0].res, 2)
        XCTAssertEqual(target["b"]![1].res, 3)
        XCTAssertEqual(target["c"]![0].res, 3)
        XCTAssertEqual(target["c"]![1].res, 4)
    }
}
