//
//  PerformanceTests.swift
//  ParserCombinatorsTests
//
//  Created by Yume on 2018/11/22.
//

import XCTest

class PerformanceTests: XCTestCase {

    let testTarget: [UInt8] = {
        var target = [UInt8].init(repeating: 0, count: 256)
        for i: UInt8 in 0...255 {
            target[Int(i)] = i
        }
        return target
    }()
    
    let testTime = 100
    func testYumeString() {
        let target = testTarget.map { "\($0)" }
        self.measure {
            for _ in 1...testTime {
                let _ = target.map { $0 == "123" }
            }
        }
    }
    func testYumeData() {
        let target = testTarget.map {Data(bytes: [$0])}
        self.measure {
            for _ in 1...testTime {
                let _ = target.map { $0 == Data(repeating: 123, count: 1) }
            }
        }
    }
    func testYumeUInt8() {
        let target = testTarget.map { [$0] }
        self.measure {
            for _ in 1...testTime
            {
                let _ = target.map { $0 == [123] }
            }
        }
    }
}
