//
//  YumeJSONKit.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public protocol JSONKitDecoder {
    static func decode(_ dic:NSDictionary?) -> Self?
}

public func <|? <T:JSONKitDecoder>(dic:NSDictionary?,key:String) -> T? {
    return T.decode(dic?[key] as? NSDictionary)
}
public func <| <T:JSONKitDecoder> (dic:NSDictionary?,key:String) throws -> T {
    guard let r:T = dic <|? key else {
        //        print("\(key)---\(dic?[key])")
        throw YumeError.WrongType
    }
    return r
    
}
public func <|| <T:JSONKitDecoder>(dic:NSDictionary?,key:String) -> [T] {
    if let temp = dic?[key] as? NSArray {
        return toArray(array: temp)
    }
    return []
}

public func toArray <T:JSONKitDecoder>(array:NSArray) -> [T] {
    return array.flatMap { T.decode($0 as? NSDictionary) }
}

//func dicToPrimitiveTypeArray<T>(dic:NSDictionary?,key:String) -> [T] {
//    return (dic?[key] as? [T]) ?? []
//}
//func <|| <T>(dic:NSDictionary?,key:String) throws -> [T] {
//    return (dic?[key] as? [T]) ?? []
//}
