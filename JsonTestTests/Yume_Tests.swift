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
    
    func testNonTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
        self.measure {
            let myJson = JSON(any: array)
            let programs:[Program] = try! myJson.toArray()
            XCTAssert(programs.count > 1000)
        }
    }
    
    func testTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
        self.measure {
            let myJson = JSON(any: array,isTraceKeypath:true)
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

extension Program: JSONDecodable {
    public static func decode(_ j: JSON) throws -> Program {
        return try Program(
                    title: j <| "Title",
                    chanId: j.getBy(key: "Channel") <| "ChanId",
                    description: j <|? "Description",
                    subtitle: j <|? "SubTitle",
                    recording: j <| "Recording",
                    season: j <|? "Season",
                    episode: j <|? "Episode"
                )

    }
}

extension Recording: JSONDecodable {
    public static func decode(_ j: JSON) throws -> Recording {
        return try Recording(
            startTsStr: j <| "StartTs",
            recordId: j <| "RecordId"
        )
    }
}
