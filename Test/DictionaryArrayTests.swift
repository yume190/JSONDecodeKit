//
//  JSONDecodableTests.swift
//  JsonTest
//
//  Created by Yume on 2016/11/7.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
//import JSONDecodeKit

//{
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
    static func decode(_ json: JSON) throws -> Res {
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
    
    func testDecodeFromFile() {
        let path = Bundle(for: type(of: self)).url(forResource: "test2", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = JSON(data: data)
        
        let dic_primitive_int:[String:Int] = json["dic"]["primitive"].toDictionary()
        let dic_primitive_res_int:[String:ResInt] = json["dic"]["primitive"].toDictionary()
        let dic_primitive_decode:[String:Res] = json["dic"]["decodeable"].toDictionary()
        XCTAssertEqual(dic_primitive_int["c"], 3)
        XCTAssertEqual(dic_primitive_res_int["c"], ResInt.c)
        XCTAssertEqual(dic_primitive_decode["c"]!.res, 3)
        
        let dicArray_primitive_int:[String:[Int]] = json["dicArray"]["primitive"].toDictionaryAndArrayValue()
        let dicArray_primitive_res_int:[String:[ResInt]] = json["dicArray"]["primitive"].toDictionaryAndArrayValue()
        let dicArray_primitive_decode:[String:[Res]] = json["dicArray"]["decodeable"].toDictionaryAndArrayValue()
        
        XCTAssertEqual(dicArray_primitive_int["c"]!, [3,4])
        XCTAssertEqual(dicArray_primitive_res_int["c"]!, [ResInt.c,ResInt.d])
        XCTAssertEqual(dicArray_primitive_decode["c"]![0].res, 3)
        
        print("abc")
        
    }
    
    
}
