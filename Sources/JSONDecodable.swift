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

extension JSON {
    static public func <|? <T:JSONDecodable>(json:JSON,key:String) -> T? {
        return try? T.decode(json.getBy(key: key))
    }
    
    static public func <| <T:JSONDecodable> (json:JSON,key:String) throws -> T {
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
    
    static public func <|| <T:JSONDecodable>(json:JSON,key:String) throws -> [T] {
        return try json.getBy(key: key).toArray()
    }
}

// MARK: Lazy Man Operators
extension JSON {
    static public func <||| <T:JSONDecodable>(json:JSON,key:String) throws -> T? {
        return json <|? key
    }
    
    static public func <||| <T:JSONDecodable> (json:JSON,key:String) throws -> T {
        return try json <| key
    }
    
    static public func <||| <T:JSONDecodable>(json:JSON,key:String) throws -> [T] {
        return try json <|| key
    }
}
