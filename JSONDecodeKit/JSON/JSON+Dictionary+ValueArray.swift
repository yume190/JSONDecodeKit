//
//  JSON+DictionaryArray.swift
//  JSONDecodeKit
//
//  Created by Yume on 2017/11/20.
//  Copyright © 2017年 Yume. All rights reserved.
//

import Foundation

// MARK: Get [Key:[Value]]
extension JSON {
        public func dictionaryValueArray<Key,Value:PrimitiveType>() -> [Key:[Value]] {
            if let dic = self.data as? NSDictionary {
                return dic.reduce([Key:[Value]]()) { (dic:[Key:[Value]], set:(key: Any, value: Any)) -> [Key:[Value]] in
                    var dic = dic
                    if let k = set.key as? Key {
                        dic[k] = JSON(any: set.value).array()
                    }
                    return dic
                }
            }
            return [Key:[Value]]()
        }
    
    public func dictionaryValueArray<Key,Value:JSONDecodable>() -> [Key:[Value]] {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:[Value]]()) { (dic:[Key:[Value]], set:(key: Any, value: Any)) -> [Key:[Value]] in
                var dic = dic
                if let k = set.key as? Key,let temp:[Value] = try? JSON(any: set.value).array() {
                    dic[k] = temp
                }
                return dic
            }
        }
        return [Key:[Value]]()
    }
    
    public func dictionaryValueArray<Key,Value:RawRepresentable>() -> [Key:[Value]] where Value.RawValue:PrimitiveType {
        if let dic = self.data as? NSDictionary {
            return dic.reduce([Key:[Value]](), { (dic:[Key:[Value]], set:(key: Any, value: Any)) -> [Key:[Value]] in
                var dic = dic
                
                if let k = set.key as? Key {
                    dic[k] = JSON(any: set.value).array()
                }
                return dic
            })
        }
        return [Key:[Value]]()
    }
}
