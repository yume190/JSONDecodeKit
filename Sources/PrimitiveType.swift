//
//  YumeJSONPrimitiveType.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public protocol PrimitiveType {
    static func decode(_ any: Any?) -> Self?
    static func decode(json: JSON) -> Self?
    init?(_ description: String)
}

extension JSON {
    static public func <|? <T:PrimitiveType>(json:JSON,key:String) -> T? {
        return T.decode(json.getBy(key: key).data)
    }
    
    static public func <| <T:PrimitiveType> (json:JSON,key:String) throws -> T {
        if let r:T = json <|? key {
            return r
        }
        
        if let data = json.getBy(key: key).data {
            if data is NSNull {
                throw JSONDecodeError.nullValue(keyPath: json.keypath, curruntKey: key, json:json)
            }
            
            throw JSONDecodeError.typeMismatch(keyPath: json.keypath, curruntKey: key, expectType: T.self, actualType: type(of:data),value: data, json:json)
        }
        throw JSONDecodeError.keyNotFound(keyPath: json.keypath, curruntKey: key, json:json)
    }
    
    static public func <|| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
        return json.getBy(key: key).toArray()
    }
}

// MARK: Lazy Man Operators
extension JSON {
    static public func <||| <T:PrimitiveType>(json:JSON,key:String) -> T? {
        return json <|? key
    }
    
    static public func <||| <T:PrimitiveType>(json:JSON,key:String) throws -> T {
        return try json <| key
    }
    
    static public func <||| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
        return json <|| key
    }
}

public extension PrimitiveType {
    static func decode(json: JSON) -> Self? {
        return decode(json.data)
    }
    
    static func decode(_ any: Any?) -> Self? {
        if let result = any as? Self {
            return result
        }
        
        if let result = any as? String {
            return Self(result)
        }
        
        return nil
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
    public static func decode(_ any: Any?) -> String? {
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
