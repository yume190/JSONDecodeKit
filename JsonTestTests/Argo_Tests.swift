////
////  Argo_Tests.swift
////  JsonTest
////
////  Created by Yume on 2016/10/24.
////  Copyright © 2016年 Yume. All rights reserved.
////
//
//import XCTest
//import Argo
////import Curry
//import Runes
//
//class Argo_Tests: XCTestCase {
//    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//}
//extension Recording: Decodable {
//    public static func decode(_ j: JSON) -> Decoded<Recording> {
//        return curry(Recording.init)
//            <^> j <| "StartTs"
//            <*> j <| "RecordId"
//    }
//}
