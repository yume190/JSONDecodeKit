//
//  JSONDecodableTests.swift
//  JsonTest
//
//  Created by Yume on 2016/11/7.
//  Copyright © 2016年 Yume. All rights reserved.
//

import XCTest
import JSONDecodeKit

//{
//    "a":1,
//    "b":"B",
//    "c":null
//}

class JSONDecodableTests: XCTestCase {
    
    func testDecodeFromFile() {
        let path = Bundle(for: type(of: self)).url(forResource: "test", withExtension: "json")
        let data = try! Data(contentsOf: path!)
        let json = JSON(data: data)
        
        let a:Int = try! json <| "a"
        XCTAssertEqual(1, a)
        let b:String = try! json <| "b"
        XCTAssertEqual("B", b)
        let c:String? = json <|? "c"
        XCTAssertNil(c)
        
        
        do {
            let _:Int = try json <| "b"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        do {
            let _:Int = try json <| "c"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        do {
            let _:Int = try json <| "d"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        
    }
    
    func testDecodeFromDictionary() {
        
        let json = JSON(any: ["a":"1","b":"B","c":nil])
        
        let a:Int = try! json <| "a"
        XCTAssertEqual(1, a)
        let b:String = try! json <| "b"
        XCTAssertEqual("B", b)
        let c:String? = json <|? "c"
        XCTAssertNil(c)
        
        
        do {
            let _:Int = try json <| "b"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        do {
            let _:Int = try json <| "c"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        do {
            let _:Int = try json <| "d"
            fatalError()
        } catch let error {
            if error is JSONDecodeError {
                print(error)
            } else {
                fatalError()
            }
        }
        
    }
    
}
