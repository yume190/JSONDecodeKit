//
//  JSONEncodable.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/7/4.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

public protocol JSONEncodable {
    static func encode(_ json:Self) -> String
}

public struct JSONEncoder {
    public static func encode(strings:String? ...) -> String {
        let result = strings.flatMap{$0}.joined(separator: ",")
        return "{" + result + "}"
    }
}

extension JSONEncoder {
    public static func encodeSingle<T:PrimitiveType>(value:T,key:String) -> String {
        let _value = encodeToString(value: value)
        return [
          key.debugDescription,
          ":",
          _value,
        ].joined()
    }
    
    public static func encodeOptional<T:PrimitiveType>(value:T?,key:String) -> String? {
        guard let _value = value else {return nil}
        return encodeSingle(value: _value, key: key)
    }
    
    public static func encodeArray<T:PrimitiveType>(value:[T]) -> String {
        return "[\(value.flatMap(encodeToString).joined(separator: ","))]"
    }
    
    public static func encodeArray<T:PrimitiveType>(value:[T],key:String) -> String {
        let _value = encodeArray(value: value)
        return [
            key.debugDescription,
            ":",
            _value,
        ].joined()
    }
    
    public static func encodeToString<T:PrimitiveType>(value:T) -> String {
        let _value:String
        if let v = value as? String {
            _value = v.debugDescription
        } else {
            _value = "\(value)"
        }
        
        return _value
    }
}

extension String {
    static public func <| <T:PrimitiveType>(value:T,key:String) -> String {
        return JSONEncoder.encodeSingle(value: value, key: key)
    }
    
    static public func <|? <T:PrimitiveType>(value:T?,key:String) -> String? {
        return JSONEncoder.encodeOptional(value: value, key: key)
    }
 
    static public func <|| <T:PrimitiveType>(value:[T],key:String) -> String {
        return JSONEncoder.encodeArray(value: value, key: key)
    }
}

extension JSONEncoder {
    public static func encodeSingle<T:JSONEncodable>(value:T,key:String) -> String {
        let _value = T.encode(value)
        return [
            key.debugDescription,
            ":",
            _value,
        ].joined()
    }
    
    public static func encodeOptional<T:JSONEncodable>(value:T?,key:String) -> String? {
        guard let _value = value else {return nil}
        return encodeSingle(value: _value, key: key)
    }
    
    public static func encodeArray<T:JSONEncodable>(value:[T]) -> String {
        let values:[String] = value.flatMap{T.encode($0)}
        return "[" + values.joined(separator: ",") + "]"
    }
    
    public static func encodeArray<T:JSONEncodable>(value:[T],key:String) -> String {
        let _value = encodeArray(value: value)
        return [
            key.debugDescription,
            ":",
            _value,
        ].joined()
    }
}

extension String {
    static public func <| <T:JSONEncodable>(value:T,key:String) -> String {
        return JSONEncoder.encodeSingle(value: value, key: key)
    }
    
    static public func <|? <T:JSONEncodable>(value:T?,key:String) -> String? {
        return JSONEncoder.encodeOptional(value: value, key: key)
    }
    
    static public func <|| <T:JSONEncodable>(value:[T],key:String) -> String {
        return JSONEncoder.encodeArray(value: value, key: key)
    }
}
