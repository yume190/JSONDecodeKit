//
//  YumeJSONKit.swift
//  JsonTest
//
//  Created by Yume on 2016/10/27.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

protocol JSONKitDecoder {
    static func decode(dic:NSDictionary?) -> Self?
}

func dicToPrimitiveType<T:PrimitiveType> (dic:NSDictionary?,key:String) -> T? {
    return T.primitive(any: dic?[key])
}
func <|? <T:PrimitiveType> (dic:NSDictionary?,key:String) -> T? {
//    if let v1 = any as? Int {
//        return v1
//    }
//    
//    if let v2 = any as? String {
//        return Int(v2)
//    }
//    
//    return nil
    return T.primitive(any: dic?[key])
}
func <|? <T:JSONKitDecoder>(dic:NSDictionary?,key:String) -> T? {
    return T.decode(dic: dic?[key] as? NSDictionary)
}


func dicToPrimitiveTypeArray<T>(dic:NSDictionary?,key:String) -> [T] {
    return (dic?[key] as? [T]) ?? []
}


func <| <T:PrimitiveType> (dic:NSDictionary?,key:String) throws -> T {
    guard let r:T = dicToPrimitiveType(dic: dic, key: key) else {
        //        print("\(key)---\(dic?[key])")
        //        NSTaggedPointerString
        
        throw YumeError.WrongType
    }
    return r
}
func <|| <T>(dic:NSDictionary?,key:String) throws -> [T] {
    return (dic?[key] as? [T]) ?? []
}


func <| <T:JSONKitDecoder> (dic:NSDictionary?,key:String) throws -> T {
    guard let r:T = dic <|? key else {
        //        print("\(key)---\(dic?[key])")
        
        throw YumeError.WrongType
    }
    return r
    
}

func <|| <T:JSONKitDecoder>(dic:NSDictionary?,key:String) -> [T] {
    if let temp = dic?[key] as? NSArray {
        return temp.flatMap { T.decode(dic: $0 as? NSDictionary) }
    }
    return []
}

func toArray <T:JSONKitDecoder>(array:NSArray) -> [T] {
    return array.flatMap { T.decode(dic: $0 as? NSDictionary) }
}


