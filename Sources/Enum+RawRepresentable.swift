//
//  YumeJSONEnum.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

//extension RawRepresentable {
//    associatedtype RawValue
//}

public func <|? <T:RawRepresentable> (json:JSON,key:String) -> T? where T.RawValue:PrimitiveType {
    if let value = T.RawValue.decode(json.getBy(key: key).data) {
        let enumValue = T(rawValue: value)
        return enumValue
    }
    return nil
}

public func <| <T:RawRepresentable> (json:JSON,key:String) throws -> T where T.RawValue:PrimitiveType {
    guard let r:T = json <|? key else {
        if let data = json.getBy(key: key).data {
            if data is NSNull {
                throw JSONDecodeError.nullValue(keyPath: json.keypath, curruntKey: key)
            }
            
            throw JSONDecodeError.typeMismatch(keyPath: json.keypath, curruntKey: key, expectType: T.self, actualType: type(of:data),value: data)
        }
        throw JSONDecodeError.keyNotFound(keyPath: json.keypath, curruntKey: key)
    }
    return r
}

public func <|| <T:RawRepresentable>(json:JSON,key:String) -> [T] where T.RawValue:PrimitiveType {
    return json.toArray()
}

// MARK: Lazy Man Operators
public func <||| <T:RawRepresentable> (json:JSON,key:String) -> T? where T.RawValue:PrimitiveType {
    return json <|? key
}

public func <||| <T:RawRepresentable> (json:JSON,key:String) throws -> T where T.RawValue:PrimitiveType {
    return try json <| key
}

public func <||| <T:RawRepresentable>(json:JSON,key:String) -> [T] where T.RawValue:PrimitiveType {
    return json <|| key
}
