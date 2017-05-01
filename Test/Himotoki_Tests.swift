//
//  Himotoki_Tests.swift
//  JsonTest
//
//  Created by Yume on 2016/10/24.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
import Himotoki

class Himotoki_Tests: XCTestCase {
    
    func testDeserialization() {
        self.measure {
            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
            XCTAssert(d.count > 0)
        }
    }
    
    
//    func testNSDictionaryPerformance() {
//        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
//        let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
//        
//        
//        self.measure {
//            let programs:[Program] = array.flatMap {try! Program.decodeValue($0)}
//            XCTAssert(programs.count > 1000)
//        }
//    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}

extension Program: Decodable {    
    public static func decode(_ j: Extractor) throws -> Program {
        return try Program(
            title: j <| "Title",
            chanId: j <| ["Channel", "ChanId"],
            description: j <|? "Description",
            subtitle: j <|? "SubTitle",
            recording: j <| "Recording",
            season: j <|? "Season",
            episode: j <|? "Episode"
        )
    }
}

extension Recording: Himotoki.Decodable{
    public static func decode(_ j: Extractor) throws -> Recording {
        return try Recording(
            startTsStr: j <| "StartTs",
            recordId: j <| "RecordId"
        )
    }
}
