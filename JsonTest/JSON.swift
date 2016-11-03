//
//  YumeJSON.swift
//  JsonTest
//
//  Created by Yume on 2016/11/3.
//  Copyright © 2016年 Yume. All rights reserved.
//

import Foundation

public struct JSON {
    public var data:Any?
    lazy var traceKeypath:[String] = []
    private var isTraceKeypath:Bool
    
    public init(data:Data,isTraceKeypath:Bool = false) {
        self.data = try? JSONSerialization.jsonObject(with: data, options: [])
        self.isTraceKeypath = isTraceKeypath
    }
    
    public init(any:Any,isTraceKeypath:Bool = false) {
        self.data = any
        self.isTraceKeypath = isTraceKeypath
    }
    
    public func getBy(key:String) -> JSON {
        var r = self
        if isTraceKeypath {
            r.traceKeypath.append(key)
        }
        r.data = (self.data as? NSDictionary)?[key]
        return r
    }
    
    public func getBy(index:Int) -> JSON {
        var r = self
        if isTraceKeypath {
            r.traceKeypath.append("[\(index)]")
        }
        r.data = (self.data as? NSArray)?[index]
        return r
    }
    
    public func getArray() -> [JSON] {
        guard let array = self.data as? NSArray else {return []}
        var index = -1
        let r:[JSON] = array.flatMap {_ in
            index += 1
            let json = self
            return json.getBy(index: index)
        }
        
        return r
    }
    
    public func toArray<T:PrimitiveType>() -> [T] {
        return self.getArray().flatMap{T.decode($0.data)}
    }
    
    public func toArray<T:JSONDecodable>() throws -> [T] {
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
    
    public func toDictionary<Key:Hashable,Value:PrimitiveType>() -> [Key:Value] {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:Value](), { (dic:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
                var dic = dic
                if let k = set.key as? Key,let v = Value.decode(set.value) {
                    dic[k] = v
                }
                return dic
            })
        }
        return [Key:Value]()
    }
    
    public func toDictionary<Key:Hashable,Value:JSONDecodable>() -> [Key:Value] {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:Value](), { (dic:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
                var dic = dic
                if let k = set.key as? Key,let v = try? Value.decode(JSON(any: set.value)) {
                    dic[k] = v
                }
                return dic
            })
        }
        return [Key:Value]()
    }
    
    public func keypath() -> String {
        var temp = self
        return temp.traceKeypath.joined(separator: ".")
    }
    
}
