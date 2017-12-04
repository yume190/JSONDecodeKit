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
//    "a": 1,
//    "b": "B",
//    "c": null,
//    "d": [1, 2, 3],
//    "e": ["1", "2", "3"]
//}

struct ABCDE {
    let a: Int
    let b: String
    let c: Int?
    let d: [Int]
    let e: [String]
}

extension ABCDE: JSONDecodable {
    static func decode(json: JSON) throws -> ABCDE {
        return try ABCDE(
            a: json <| "a",
            b: json <| "b",
            c: json <|? "c",
            d: json <|| "d",
            e: json <|| "e"
        )
    }
}

extension ABCDE: JSONSerializable {}

class JSONDecodableTests: XCTestCase {
    private lazy var json:JSON = {
        let path = Bundle(for: type(of: self)).url(forResource: "test", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = JSON(data: data)
        return json
    }()
    
    func testDecodeFromFile() {
        var abcde = try! ABCDE.decode(json: self.json)
        XCTAssertEqual(abcde.a, 1)
        XCTAssertEqual(abcde.b, "B")
        XCTAssertNil(abcde.c)
        XCTAssertEqual(abcde.d, [1,2,3])
        XCTAssertEqual(abcde.e, ["1", "2", "3"])
        
        let serializeData = abcde.toJSON().data(using: .utf8)!
        let serializeJson = JSON(data: serializeData)
        abcde = try! ABCDE.decode(json: serializeJson)
        XCTAssertEqual(abcde.a, 1)
        XCTAssertEqual(abcde.b, "B")
        XCTAssertNil(abcde.c)
        XCTAssertEqual(abcde.d, [1,2,3])
        XCTAssertEqual(abcde.e, ["1", "2", "3"])
    }
}
