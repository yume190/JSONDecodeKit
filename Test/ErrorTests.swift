//
//  ErrorTests.swift
//  JSONDecodeKit
//
//  Created by Yume on 2018/1/8.
//  Copyright © 2018年 Yume. All rights reserved.
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
//            "d": null,
//            "f": 5.5,
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

class ErrorTests: XCTestCase {
    
    func testKeyNotFound() {
        let json = JSON(data: self.data, isTraceKeypath: true)
        
        do {
            let _: Int = try json["dic"]["primitive"] <| "e"
        } catch let error as JSONDecodeError {
            switch error {
            case .keyNotFound(let base):
                XCTAssertEqual(base.keyPath, ".dic.primitive")
                XCTAssertEqual(base.currentKey, "e")
                NSLog("\(error)")
            default:
                fatalError()
            }
            return
        } catch {
            fatalError()
        }
        fatalError()
    }
    
    func testNullValue() {
        let json = JSON(data: self.data, isTraceKeypath: true)
        
        do {
            let _: Int = try json["dic"]["primitive"] <| "d"
        } catch let error as JSONDecodeError {
            switch error {
            case .nullValue(let base):
                XCTAssertEqual(base.keyPath, ".dic.primitive")
                XCTAssertEqual(base.currentKey, "d")
                NSLog("\(error)")
            default:
                fatalError()
            }
            return
        } catch {
            fatalError()
        }
        fatalError()
    }
    
    func testTypeMismatch() {
        let json = JSON(data: self.data, isTraceKeypath: true)

        do {
            let _: Bool = try json["dic"]["primitive"] <| "f"
        } catch let error as JSONDecodeError {
            switch error {
            case .typeMismatch(let base, let extra):
                XCTAssertEqual(base.keyPath, ".dic.primitive")
                XCTAssertEqual(base.currentKey, "f")

                XCTAssertTrue(extra.expectType is Bool.Type)
                XCTAssertTrue(extra.actualType is NSNumber.Type)
                XCTAssertEqual((extra.value as! Double), 5.5)
                NSLog("\(error)")
                return
            default:
                fatalError()
            }

            return
        } catch {
            fatalError()
        }
        fatalError()
    }
    
    private lazy var data:Data = {
        let path = Bundle(for: type(of: self)).url(forResource: "test2", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        return data
    }()
    
}
