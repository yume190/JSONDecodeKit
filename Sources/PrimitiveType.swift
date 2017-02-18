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
    init?(text: String)
    // TODO: init with JSON
    //    init?(json: JSON)
}

public func <|? <T:PrimitiveType>(json:JSON,key:String) -> T? {
    return T.decode(json.getBy(key: key).data)
}

public func <| <T:PrimitiveType> (json:JSON,key:String) throws -> T {
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

public func <|| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
    return json.getBy(key: key).toArray()
}

// MARK: Lazy Man Operators
public func <||| <T:PrimitiveType>(json:JSON,key:String) -> T? {
    return json <|? key
}

public func <||| <T:PrimitiveType> (json:JSON,key:String) throws -> T {
    return try json <| key
}

public func <||| <T:PrimitiveType>(json:JSON,key:String) -> [T] {
    return json <|| key
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
            return Self(text: result)
        }
        
        return nil
    }
    
    // TODO: init with JSON
    //    init?(json: JSON) {
    //        return Self.decode(json.data)
    //    }
    
}

// MARK: Int
extension Int:PrimitiveType{
    public init?(text: String) {
        guard let result = Int(text) else { return nil }
        self = result
    }
}
extension Int8:PrimitiveType{
    public  init?(text: String) {
        guard let result = Int8(text) else { return nil }
        self = result
    }
}
extension Int16:PrimitiveType{
    public  init?(text: String) {
        guard let result = Int16(text) else { return nil }
        self = result
    }
}
extension Int32:PrimitiveType{
    public  init?(text: String) {
        guard let result = Int32(text) else { return nil }
        self = result
    }
}
extension Int64:PrimitiveType{
    public  init?(text: String) {
        guard let result = Int64(text) else { return nil }
        self = result
    }
}

// MARK: UInt
extension UInt:PrimitiveType{
    public init?(text: String) {
        guard let result = UInt(text) else { return nil }
        self = result
    }
}
extension UInt8:PrimitiveType{
    public init?(text: String) {
        guard let result = UInt8(text) else { return nil }
        self = result
    }
}
extension UInt16:PrimitiveType{
    public init?(text: String) {
        guard let result = UInt16(text) else { return nil }
        self = result
    }
}
extension UInt32:PrimitiveType{
    public init?(text: String) {
        guard let result = UInt32(text) else { return nil }
        self = result
    }
}
extension UInt64:PrimitiveType{
    public init?(text: String) {
        guard let result = UInt64(text) else { return nil }
        self = result
    }
}

// MARK: Float
extension Float:PrimitiveType{
    public init?(text: String) {
        guard let result = Float(text) else { return nil }
        self = result
    }
}
extension Double:PrimitiveType{
    public init?(text: String) {
        guard let result = Double(text) else { return nil }
        self = result
    }
}

// Mark: Bool
extension Bool:PrimitiveType{
    public init?(text: String) {
        guard let result = Bool(text) else { return nil }
        self = result
    }
}

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
    
    public init?(text: String) {
        self = text
    }
}

extension URL:PrimitiveType {
    public init?(text: String) {
        guard let result = URL(string: text) else { return nil }
        self = result
    }
}

//extension Array where Element: ValueType {
//extension Dictionary: ValueType {
//extension Set where Element: ValueType {
//extension Character: ValueType {
