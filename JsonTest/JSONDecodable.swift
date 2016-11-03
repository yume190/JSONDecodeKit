//
//  YumeJSONKit.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    static func decode(_ json:JSON) throws -> Self
}

public func <|? <T:JSONDecodable>(json:JSON,key:String) throws -> T? {
    return try T.decode(json.getBy(key: key))
}

public func <| <T:JSONDecodable> (json:JSON,key:String) throws -> T {
    guard let r:T = try json <|? key else {
        if let data = json.getBy(key: key).data {
            if data is NSNull {
                throw JSONDecodeError.nullValue(keyPath: json.keypath(), curruntKey: key)
            }
            
            throw JSONDecodeError.typeMismatch(keyPath: json.keypath(), curruntKey: key, expectType: T.self, actualType: type(of:data),value: data)
        }
        throw JSONDecodeError.keyNotFound(keyPath: json.keypath(), curruntKey: key)
    }
    return r
    
}

public func <|| <T:JSONDecodable>(json:JSON,key:String) throws -> [T] {
    return try json.getBy(key: key).toArray()
}

// MARK: Lazy Man Operators
public func <||| <T:JSONDecodable>(json:JSON,key:String) throws -> T? {
    return try json <|? key
}

public func <||| <T:JSONDecodable> (json:JSON,key:String) throws -> T {
    return try json <| key
}

public func <||| <T:JSONDecodable>(json:JSON,key:String) throws -> [T] {
    return try json <|| key
}
