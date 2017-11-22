//
//  PrimitiveType.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/17.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

public protocol PrimitiveType:JSONDecodable {
    static func decode(any: Any?) throws -> Self
    static func number(number: NSNumber) -> Self
    init?(_ description: String)
}

public extension PrimitiveType {
    static func decode(any: Any?) throws -> Self {
        if let number = any as? NSNumber {
            return Self.number(number: number)
        }
        
        guard let string = any as? String, let result = Self(string) else {
            throw JSONDecodeError.specialCase(reason: "...")
        }
        
        return result
    }
    
    static func decode(json: JSON) throws -> Self {
        return try decode(any: json.data)
    }
}

// MARK: Int
extension Int:PrimitiveType {
    public static func number(number: NSNumber) -> Int {
        return number.intValue
    }
}
extension Int8:PrimitiveType {
    public static func number(number: NSNumber) -> Int8 {
        return number.int8Value
    }
}
extension Int16:PrimitiveType {
    public static func number(number: NSNumber) -> Int16 {
        return number.int16Value
    }
}
extension Int32:PrimitiveType {
    public static func number(number: NSNumber) -> Int32 {
        return number.int32Value
    }
}
extension Int64:PrimitiveType {
    public static func number(number: NSNumber) -> Int64 {
        return number.int64Value
    }
}

// MARK: UInt
extension UInt:PrimitiveType {
    public static func number(number: NSNumber) -> UInt {
        return number.uintValue
    }
}
extension UInt8:PrimitiveType {
    public static func number(number: NSNumber) -> UInt8 {
        return number.uint8Value
    }
}
extension UInt16:PrimitiveType {
    public static func number(number: NSNumber) -> UInt16 {
        return number.uint16Value
    }
}
extension UInt32:PrimitiveType {
    public static func number(number: NSNumber) -> UInt32 {
        return number.uint32Value
    }
}
extension UInt64:PrimitiveType {
    public static func number(number: NSNumber) -> UInt64 {
        return number.uint64Value
    }
}

// MARK: Float
extension Float:PrimitiveType {
    public static func number(number: NSNumber) -> Float {
        return number.floatValue
    }
}
extension Double:PrimitiveType {
    public static func number(number: NSNumber) -> Double {
        return number.doubleValue
    }
}

// Mark: Bool
extension Bool:PrimitiveType {
    public static func number(number: NSNumber) -> Bool {
        return number.boolValue
    }
}

// MARK: String
extension String:PrimitiveType {
//    public static func decode(any: Any?) -> String? {
    public static func decode(any: Any?) throws -> String {
        if let result = any as? String { return result }
        guard let any = any else { throw JSONDecodeError.specialCase(reason: "...") }
        if any is NSNull { throw JSONDecodeError.specialCase(reason: "...") }
        return String(describing: any)
    }
    public init?(_ description: String) {
        self = description
    }
    public static func number(number: NSNumber) -> String {
        return number.stringValue
    }
}

//extension URL:PrimitiveType {
//    public init?(_ description: String) {
//        guard let result = URL(string: description) else { return nil }
//        self = result
//    }
//}

//extension Array where Element: ValueType {
//extension Dictionary: ValueType {
//extension Set where Element: ValueType {
//extension Character: ValueType {
