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
    init?(text: String)
}

public func <|? <T:PrimitiveType>(json:YJSON,key:String) -> T? {
    return T.decode(json.getBy(key: key).data)
}

public func <| <T:PrimitiveType> (json:YJSON,key:String) throws -> T {
    guard let r:T = json <|? key else {
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

public func <|| <T:PrimitiveType>(json:YJSON,key:String) -> [T] {
    return json.getBy(key: key).toArray()
}

//
//public func <|? <T:PrimitiveType> (dic:YJSON,key:String) -> T? {
//    return T.decode(any: dic?[key])
//}
//public func <| <T:PrimitiveType> (dic:YJSON,key:String) throws -> T {
//    guard let r:T = dic <|? key else {
//        //        print("\(key)---\(dic?[key])")
//        //        NSTaggedPointerString
//
//        throw YumeError.WrongType
//    }
//    return r
//}
//public func <|| <T:PrimitiveType>(dic:YJSON,key:String) -> [T] {
//    if let temp = dic?[key] as? NSArray {
//        return toArray(array: temp)
//    }
//    return []
//}
//
//public func toArray <T:PrimitiveType>(array:NSArray) -> [T] {
//    return array.flatMap { T.decode(any: $0) }
//}

public extension PrimitiveType {
    static func decode(_ any: Any?) -> Self? {
        if let result = any as? Self {
            return result
        }
        
        if let result = any as? String {
            return Self(text: result)
        }
        
        return nil
    }
}

// MARK: Int
extension Int:PrimitiveType{
    public init?(text: String) {
        guard let result = Int(text) else { return nil }
        
        //        static func value(from object: Any) throws -> Value
        //        let a:Any = 1
        //        Int(a)
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
    public  init?(text: String) {
        guard let result = UInt(text) else { return nil }
        self = result
    }
}
extension UInt8:PrimitiveType{
    public  init?(text: String) {
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
//extension Float:PrimitiveType{
//    internal init?(_ text: String) {
//        guard let result = Float(text) else { return nil }
//        self = result
//    }
//}
extension Float32:PrimitiveType{
    public init?(text: String) {
        guard let result = Float32(text) else { return nil }
        self = result
    }
}
extension Float64:PrimitiveType{
    public init?(text: String) {
        guard let result = Float64(text) else { return nil }
        self = result
    }
}
//extension Float80:PrimitiveType{
//    public init?(text: String) {
//        guard let result = Float80(text) else { return nil }
//        self = result
//    }
//}

// MARK: Double
//extension Double:PrimitiveType{
//    internal init?(_ text: String) {
//        guard let result = Double(text) else { return nil }
//        self = result
//    }
//}

// Mark: Bool
extension Bool:PrimitiveType{
    public init?(text: String) {
        guard let result = Bool(text) else { return nil }
        self = result
    }
}

// MARK: String
extension String:PrimitiveType {
    public static func decode(_ any: Any) -> String? {
        print("String decode1")
        if let result = any as? String {
            return result
        }
        print("String decode2")
        let _any:Any? = any
        if _any == nil {
            return nil
        }
        print("String decode3")
        return String(describing: any)
        //        return nil
    }
    
    public init?(text: String) {
        self = text
    }
}

//extension Array where Element: ValueType {
//    public static func value(from object: Any) throws -> [Element] {
//        guard let anyArray = object as? [AnyObject] else {
//            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
//        }
//        return try anyArray.map {
//            let value = try Element.value(from: $0)
//            guard let element = value as? Element else {
//                throw MarshalError.typeMismatch(expected: Element.self, actual: type(of: value))
//            }
//            return element
//        }
//    }
//}
//
//extension Dictionary: ValueType {
//    public static func value(from object: Any) throws -> [Key: Value] {
//        guard let objectValue = object as? [Key: Value] else {
//            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
//        }
//        return objectValue
//    }
//}
//
//extension Set where Element: ValueType {
//    public static func value(from object: Any) throws -> Set<Element> {
//        let elementArray = try [Element].value(from: object)
//        return Set<Element>(elementArray)
//    }
//}
//
//extension URL: ValueType {
//    public static func value(from object: Any) throws -> URL {
//        guard let urlString = object as? String, let objectValue = URL(string: urlString) else {
//            throw MarshalError.typeMismatch(expected: self, actual: type(of: object))
//        }
//        return objectValue
//    }
//}
//extension Character: ValueType {
//    public static func value(from object: Any) throws -> Character {
//        guard let value = object as? String else {
//            throw MarshalError.typeMismatch(expected: Value.self, actual: type(of: object))
//        }
//        return Character(value)
//    }
//}
