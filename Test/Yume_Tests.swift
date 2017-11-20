//
//  Yume_Tests.swift
//  JsonTest
//
//  Created by Yume on 2016/10/24.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
@testable import JSONDecodeKit

class Yume_Tests: XCTestCase {
    
    func testNonTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
        self.measure {
            let myJson = JSON(any: json)
            let programs:[Program] = try! myJson["ProgramList"]["Programs"].array()
            XCTAssert(programs.count > 1000)
        }
    }
    
    func testTrace() {
        let json = try! JSONSerialization.jsonObject(with: self.data, options: []) as! NSDictionary
        self.measure {
            let myJson = JSON(any: json,isTraceKeypath:true)
            let programs:[Program] = try! myJson["ProgramList"]["Programs"].array()
            XCTAssert(programs.count > 1000)
        }
    }
    
//    func testDirection() {
//        let directions1:[Route] = try! JSON(data: self.directionData).array()
//        
//        let directionsJSONString1 = JSONEncoder.encodeArray(value: directions1)
//        let directionsData1 = directionsJSONString1.data(using: .utf8)!
//        do {
//            let directions2:[Route] = try JSON(data: directionsData1).array()
//            let directionsJSONString2 = JSONEncoder.encodeArray(value: directions2)
//            XCTAssertEqual(directionsJSONString1, directionsJSONString2)
//        } catch {
//            print(error)
//            fatalError()
//        }
//    }
    
//    func testDD() {
//        let json = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
//        let array = json.value(forKeyPath: "ProgramList.Programs") as! NSArray
//        let myJson = JSON(any: array,isTraceKeypath:true)
//        let programs:[Program] = try! myJson.toArray()
//        let p1Before = programs[0]
//        let p1JSONString = p1Before.toJSON()
//        
//        let json2 = try! JSONSerialization.jsonObject(with: p1JSONString.data(using: .utf8)!, options: [])
//        let myJson2 = JSON(any: json2)
//        let p1After = try! Program.decode(myJson2)
//        
//    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
    private lazy var directionData:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "direction", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
}

extension Program: JSONDecodable {
    public static func decode(json: JSON) throws -> Program {
        return try Program(
            title: json <| "Title",
            description: json <|? "Description",
            subtitle: json <|? "SubTitle",
            recording: json <| "Recording",
            season: json <|? "Season",
            episode: json <|? "Episode"
        )
    }
}

extension Recording: JSONDecodable {
    public static func decode(json: JSON) throws -> Recording {
        return try Recording(
            startTsStr: json <| "StartTs",
            recordId: json <| "RecordId"
        )
    }
}
