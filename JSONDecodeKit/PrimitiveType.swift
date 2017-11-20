//
//  PrimitiveType.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/17.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

public protocol PrimitiveType {
    static func decode(any: Any?) -> Self?
    static func decode(json: JSON) -> Self?
    //    static func decode(this: Self) -> Self
    init?(_ description: String)
}

public extension PrimitiveType {
    static func decode(any: Any?) -> Self? {
        if let result = any as? Self {
            return result
        }
        
        
        if let result = any as? String {
            return Self(result)
        }
        
        return nil
    }
    
    //    static func decode(this: Self) -> Self {
    //        return this
    //    }
    
    // !!!!!!!!
    static func decode(json: JSON) -> Self? {
        return decode(any: json.data)
    }
}

// MARK: Int
extension Int:PrimitiveType {}
extension Int8:PrimitiveType {}
extension Int16:PrimitiveType {}
extension Int32:PrimitiveType {}
extension Int64:PrimitiveType {}

// MARK: UInt
extension UInt:PrimitiveType {}
extension UInt8:PrimitiveType {}
extension UInt16:PrimitiveType {}
extension UInt32:PrimitiveType {}
extension UInt64:PrimitiveType {}

// MARK: Float
extension Float:PrimitiveType {}
extension Double:PrimitiveType {}

// Mark: Bool
extension Bool:PrimitiveType {}

// MARK: String
extension String:PrimitiveType {
    public static func decode(any: Any?) -> String? {
        if let result = any as? String {
            return result
        }
        
        guard let _any = any else { return nil }
        if _any is NSNull {
            return nil
        }
        
        return String(describing: _any)
    }
    public init?(_ description: String) {
        self = description
    }
}

extension URL:PrimitiveType {
    public init?(_ description: String) {
        guard let result = URL(string: description) else { return nil }
        self = result
    }
}

//extension Array where Element: ValueType {
//extension Dictionary: ValueType {
//extension Set where Element: ValueType {
//extension Character: ValueType {
