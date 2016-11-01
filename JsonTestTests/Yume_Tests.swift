//
//  Yume_Tests.swift
//  JsonTest
//
//  Created by Yume on 2016/10/24.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
@testable import JsonTest

class Yume_Tests: XCTestCase {
    
    func testNSDictionaryPerformance() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
//        let json = YJSON(any: try! JSONSerialization.jsonObject(with: self.data as Data, options: []))
        self.measure {
            let myJson = YJSON(any: array)
            let programs:[Program] = try! myJson.toArray()
            XCTAssert(programs.count > 1000)
        }
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
}

extension Program: JSONKitDecoder {
    public static func decode(_ j: YJSON) throws -> Program {
        return try Program(
                    title: j <| "Title",
//                    chanId: j <|? "Channel",
                    description: j <|? "Description",
                    subtitle: j <|? "SubTitle",
                    recording: j <| "Recording",
                    season: j <|? "Season",
                    episode: j <|? "Episode"
                )

    }
}

extension Recording: JSONKitDecoder{
    public static func decode(_ j: YJSON) throws -> Recording {
        return try Recording(
            startTsStr: j <| "StartTs",
            recordId: j <| "RecordId"
        )
    }
}
