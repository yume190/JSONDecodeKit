//
//  YumeJSONKit.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public struct YJSON {
    public var data:Any?
    public var traceKeypath:[String] = []
    
    public init(data:Data) {
        self.data = try? JSONSerialization.jsonObject(with: data, options: [])
    }
    
    public init(any:Any) {
        self.data = any
    }
    
    public func getBy(key:String) -> YJSON {
        var r = self
        r.traceKeypath.append(key)
        r.data = (self.data as? NSDictionary)?[key]
        return r
    }
    
    public func getBy(index:Int) -> YJSON {
        var r = self
        r.traceKeypath.append("[\(index)]")
        r.data = (self.data as? NSArray)?[index]
        return r
    }
    
    public func getArray() -> [YJSON] {
        guard let array = self.data as? NSArray else {return []}
        var index = -1
        let r:[YJSON] = array.flatMap {_ in
            index += 1
            let json = self
            return json.getBy(index: index)
        }
        
        return r
    }
    
    public func toArray<T:PrimitiveType>() -> [T] {
        return self.getArray().flatMap{T.decode($0.data)}
    }
    
    public func toArray<T:JSONKitDecoder>() throws -> [T] {
        return try self.getArray().flatMap{ json in
            return try T.decode(json)
        }
    }
    
    public func toArray<T:RawRepresentable>() -> [T] where T.RawValue:PrimitiveType {
        return self.getArray().flatMap{
            if let value = T.RawValue.decode($0.data) {
                let enumValue = T(rawValue: value)
                return enumValue
            }
            return nil
        }
    }
    
}

public protocol JSONKitDecoder/*:JSONKitTrace*/ {
    static func decode(_ dic:YJSON) throws -> Self
}

public func <|? <T:JSONKitDecoder>(json:YJSON,key:String) throws -> T? {
    return try T.decode(json.getBy(key: key))
}

public func <| <T:JSONKitDecoder> (json:YJSON,key:String) throws -> T {
    guard let r:T = try json <|? key else {
        if let data = json.getBy(key: key).data {
            if data is NSNull {
                throw YumeError.nullValue(keyPath: json.traceKeypath.joined(separator: "."), curruntKey: key)
            }
            
            throw YumeError.typeMismatch(keyPath: json.traceKeypath.joined(separator: "."), curruntKey: key, expectType: T.self, actualType: type(of:data),value: data)
        }
        throw YumeError.keyNotFound(keyPath: json.traceKeypath.joined(separator: "."), curruntKey: key)
    }
    return r
    
}

public func <|| <T:JSONKitDecoder>(json:YJSON,key:String) throws -> [T] {
    return try json.getBy(key: key).toArray()
}
