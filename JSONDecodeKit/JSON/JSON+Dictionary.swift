//
//  JSON+Dictionary.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

extension JSON {
    public func dictionary<Key,Value:PrimitiveType>() -> [Key:Value] {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:Value](), { (dic:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
                var dic = dic
                if let k = set.key as? Key,let v = Value.decode(any: set.value) {
                    dic[k] = v
                }
                return dic
            })
        }
        return [Key:Value]()
    }
    
    public func dictionary<Key,Value:JSONDecodable>() -> [Key:Value] {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:Value](), { (dic:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
                var dic = dic
                if let k = set.key as? Key,let v = try? Value.decode(json: JSON(any: set.value)) {
                    dic[k] = v
                }
                return dic
            })
        }
        return [Key:Value]()
    }
    
    public func dictionary<Key,Value:RawRepresentable>() -> [Key:Value] where Value.RawValue:PrimitiveType {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:Value](), { (dic:[Key:Value], set:(key: Any, value: Any)) -> [Key:Value] in
                var dic = dic
                
                if let k = set.key as? Key,let v = Value.decode(any: set.value) {
                    dic[k] = v
                }
                return dic
            })
        }
        return [Key:Value]()
    }
}
