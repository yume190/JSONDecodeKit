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
        
        self.measure {
            let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
            let programs:[Program] = toArray(array: array)
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
    static func decode(dic j: NSDictionary?) -> Program? {
        return try? Program(
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
    static func decode(dic j: NSDictionary?) -> Recording? {
        return try? Recording(
            startTsStr: j <| "StartTs",
            recordId: j <| "RecordId"
        )
    }
}
