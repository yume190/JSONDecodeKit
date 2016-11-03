//
//  YumeJSONKit.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

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
                throw YumeError.nullValue(keyPath: json.keypath(), curruntKey: key)
            }
            
            throw YumeError.typeMismatch(keyPath: json.keypath(), curruntKey: key, expectType: T.self, actualType: type(of:data),value: data)
        }
        throw YumeError.keyNotFound(keyPath: json.keypath(), curruntKey: key)
    }
    return r
    
}

public func <|| <T:JSONKitDecoder>(json:YJSON,key:String) throws -> [T] {
    return try json.getBy(key: key).toArray()
}

// MARK: Lazy Man Operators
public func <||| <T:JSONKitDecoder>(json:YJSON,key:String) throws -> T? {
    return try json <|? key
}

public func <||| <T:JSONKitDecoder> (json:YJSON,key:String) throws -> T {
    return try json <| key
}

public func <||| <T:JSONKitDecoder>(json:YJSON,key:String) throws -> [T] {
    return try json <|| key
}
