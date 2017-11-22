//
//  JSON+Dictionary.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

extension JSON {    
    public func dictionary<Key,Value:JSONDecodable>() -> [Key:Value] {
        return toDictionary(json: self) { (any:Any) -> Value? in
            try? Value.decode(json: JSON(any: any))
        }
    }
    
    public func dictionary<Key,Value:RawRepresentable>() -> [Key:Value] where Value.RawValue:PrimitiveType {
        return toDictionary(json: self) { (any:Any) -> Value? in
            try? Value.decode(any: any)
        }
    }
}

private func toDictionary<Key,Value>(json: JSON, valueTransform:(Any) -> Value?) -> [Key:Value] {
    guard let dic = json.data as? NSDictionary else {
        return [Key:Value]()
    }
    
    return dic.reduce([Key:Value]()) { (result:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
        guard
            let key = set.key as? Key,
            let value = valueTransform(set.value)
            else {
                return result
        }
        
        var result = result
        result[key] = value
        return result
    }
}

