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

public func <|? <T:RawRepresentable> (dic:NSDictionary?,key:String) -> T? where T.RawValue:PrimitiveType {
    if let value = T.RawValue.decode(any: dic?[key]) {
        let enumValue = T(rawValue: value)
        return enumValue
    }
    return nil
}
public func <| <T:RawRepresentable> (dic:NSDictionary?,key:String) throws -> T where T.RawValue:PrimitiveType {
    guard let r:T = dic <|? key else {        
        throw YumeError.WrongType
    }
    return r
}
public func <|| <T:RawRepresentable>(dic:NSDictionary?,key:String) -> [T] where T.RawValue:PrimitiveType {
    if let temp = dic?[key] as? NSArray {
        return toArray(array: temp)
    }
    return []
}

public func toArray <T:RawRepresentable>(array:NSArray) -> [T] where T.RawValue:PrimitiveType {
    return array.flatMap {
        if let value = T.RawValue.decode(any: $0) {
            let enumValue = T(rawValue: value)
            return enumValue
        }
        return nil
    }
}
