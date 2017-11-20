////
////  Himotoki_Tests.swift
////  JsonTest
////
////  Created by Yume on 2016/10/24.
////  Copyright © 2016年 Yume. All rights reserved.
////
//
//import XCTest
//import Himotoki
//
//class Swift4Tests: XCTestCase {
//
//    func testDeserialization() {
//        self.measure {
//            let d:NSDictionary = try! JSONSerialization.jsonObject(with: self.data as Data, options: []) as! NSDictionary
//            XCTAssert(d.count > 0)
//        }
//    }
//
//
//    func testNSDictionaryPerformance() {
//        let decoder = JSONDecoder()
//        self.measure {
//            let programList = try! decoder.decode(ProgramList.self, from: self.data)
//            XCTAssert(programList.ProgramList.Programs.count > 1000)
//        }
//    }
//
//    private lazy var data:Data = {
//        let abc:Swift.Decodable
//        let path = Bundle(for: type(of: self)).url(forResource: "Large", withExtension: "json")
//        let data = try! Data(contentsOf: path!)
//        return data
//    }()
//
//}
//struct ProgramList:Codable {
//    let ProgramList:Programs
//}
//struct Programs:Codable {
//    let Programs:[Program]
//}
////extension Program: Swift.Codable {}
////extension Recording: Swift.Codable{}
//
//
